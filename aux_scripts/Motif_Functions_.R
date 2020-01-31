
motifScores2=function (sequences, motifs, raw.scores = FALSE, verbose = TRUE, 
    cutoff = NULL) 
{
    #if (!is.null(.PWMEnrich.Options[["useBigMemory"]]) && .PWMEnrich.Options[["useBigMemory"]]) 
        #return(motifScoresBigMemory(sequences, motifs, raw.scores, 
            #verbose, cutoff))
    pwms = .inputParamMotifs(motifs)
    sequences = .inputParamSequences(sequences)
    if (is(sequences, "DNAStringSet")) {
        al = alphabetFrequency(sequences)
    }
    else {
        al = do.call("rbind", lapply(sequences, alphabetFrequency))
    }
    all.n = which(al[, "N"] == rowSums(al))
    if (length(all.n) > 0) {
        stop(paste("Sequence with index(es):", paste(all.n, collapse = ","), 
            "only contain N's. Please remove this sequence as the PWM score cannot be computed for any position."))
    }
    #setting rev to be the same as fwd
    pwms.rev = pwms
    if (!is.null(cutoff)) {
        if (length(cutoff) == 1) {
            cutoff = rep(cutoff, length(pwms))
        }
        else if (length(cutoff) != length(pwms)) {
            stop("The lengths of cutoff and pwms do not match. Either provide one values for cutoff, or a vector of values, one for each PWM")
        }
    }
    motifScoresLoop = function(i) {
        if (verbose) 
            message(paste("Scanning sequence", i, "/", length(sequences)))
        s = sequences[[i]]
        if (raw.scores) {
            r = matrix(0, nrow = length(s) * 2, ncol = length(pwms))
            colnames(r) = names(pwms)
        }
        else {
            r = rep(0, length(pwms))
            names(r) = names(pwms)
        }
        for (j in 1:length(pwms)) {
            if (raw.scores) {
                r[, j] = as.vector(scanWithPWM(pwms[[j]], s, 
                  pwms.rev[[j]], odds.score = TRUE, both.strands = TRUE))
            }
            else if (!is.null(cutoff)) {
                r.pwm = scanWithPWM(pwms[[j]], s, pwms.rev[[j]], 
                  odds.score = FALSE, both.strands = TRUE)
                r[j] = sum(r.pwm >= cutoff[j], na.rm = TRUE)
            }
            else {
                r[j] = mean(scanWithPWM(pwms[[j]], s, pwms.rev[[j]], 
                  odds.score = TRUE), na.rm = TRUE)
            }
        }
        r
    }
    if (!is.null(.PWMEnrich.Options[["numCores"]])) {
        cat("Parallel scanning with", .PWMEnrich.Options[["numCores"]], 
            "cores\n")
        res = mclapply(1:length(sequences), motifScoresLoop, 
            mc.cores = .PWMEnrich.Options[["numCores"]])
        if (is.list(res)) {
            if (any(sapply(res, is.null))) {
                stop("Parallel scanning failed for some sequences. This could be due to a number of reasons including not enough memory.")
            }
        }
    }
    else {
        res = lapply(1:length(sequences), motifScoresLoop)
    }
    if (raw.scores) {
        names(res) = names(sequences)
        return(res)
    }
    else {
        if (length(pwms) == 1) {
            return(matrix(sapply(res, identity), ncol = 1, dimnames = list(NULL, 
                names(pwms))))
        }
        else {
            r = t(sapply(res, identity))
            rownames(r) = names(sequences)
            colnames(r) = names(pwms)
            return(r)
        }
    }
}




motifEnrichment2=function (sequences, pwms, score = "autodetect", bg = "autodetect", 
    cutoff = NULL, verbose = TRUE, motif.shuffles = 30, B = 1000, 
    group.only = FALSE) 
{
    if (score == "autodetect") {
        if (class(pwms) == "PWMLognBackground") {
            score = "affinity"
        }
        else if (class(pwms) == "PWMCutoffBackground") {
            score = "cutoff"
        }
        else {
            score = "affinity"
        }
    }
    if (score == "cutoff" & is.null(cutoff)) 
        cutoff = pwms@bg.cutoff
    pwmobj = NULL
    if (!(bg %in% c("none", "ms"))) {
        if (class(pwms) == "PWMLognBackground") {
            bg = "logn"
            pwmobj = pwms
            pwms = pwmobj@pwms
        }
        else if (class(pwms) == "PWMCutoffBackground") {
            bg = "z"
            pwmobj = pwms
            pwms = pwmobj@pwms
        }
        else if (class(pwms) == "PWMEmpiricalBackground") {
            bg = "pval"
            pwmobj = pwms
            pwms = pwmobj@pwms
        }
        else if (class(pwms) == "PWMGEVBackground") {
            bg = "gev"
            pwmobj = pwms
            pwms = pwmobj@pwms
        }
        else {
            bg = "none"
        }
    }
    if (!is.list(pwms)) 
        pwms = list(pwms)
    sequences = .inputParamSequences(sequences)
    res = list(score = score, bg = bg, pwms = pwms, sequences = sequences, 
        params = list())
    if (score == "affinity") {
        seq.len = sapply(sequences, length)
        pwm.len = sapply(pwms, length)
        res$sequence.nobg = motifScores2(sequences, pwms, verbose = verbose)
        res$group.nobg = affinitySequenceSet(res$sequence.nobg, 
            seq.len, pwm.len)
    }
    else if (score == "clover") {
        res$sequence.nobg = motifScores2(sequences, pwms, verbose = verbose)
        res$group.nobg = cloverScore(res$sequence.nobg, verbose = verbose)
    }
    else if (score == "cutoff") {
        res$params = list(cutoff = cutoff)
        res$sequence.nobg = motifScores2(sequences, pwms, cutoff = cutoff, 
            verbose = verbose)
        res$group.nobg = colSums(res$sequence.nobg)
    }
    else {
        stop(paste("Unknown scoring algorithm: '", score, "'. Please select one of: 'affinity', 'cutoff', 'clover'", 
            sep = ""))
    }
    if (verbose) {
        cat("Calculating motif enrichment scores ...\n")
    }
    if (bg == "none") {
        res$sequence.bg = NULL
        res$group.bg = NULL
    }
    else if (bg == "logn") {
        seq.len = sapply(sequences, length)
        pwm.len = sapply(pwms, length)
        res$sequence.bg = logNormPval(res$sequence.nobg, seq.len, 
            pwm.len, pwmobj@bg.mean, pwmobj@bg.sd, pwmobj@bg.len)
        colnames(res$sequence.bg) = names(pwms)
        res$sequence.norm = apply(res$sequence.bg, 1:2, qlnorm, 
            lower.tail = FALSE)
        if (score == "affinity") {
            if (is.matrix(pwmobj@bg.mean)) {
                res$group.bg = apply(res$sequence.bg, 2, function(x) {
                  pchisq(-2 * sum(log(x)), 2 * length(x), lower.tail = FALSE)
                })
                res$group.norm = sapply(res$group.bg, qlnorm, 
                  lower.tail = FALSE)
            }
            else {
                res$group.bg = logNormPvalSequenceSet(res$sequence.nobg, 
                  seq.len, pwm.len, pwmobj@bg.mean, pwmobj@bg.sd, 
                  pwmobj@bg.len)
                res$group.norm = sapply(res$group.bg, qlnorm, 
                  lower.tail = FALSE)
            }
        }
        else if (score == "clover") {
            res$group.bg = cloverScore(res$sequence.norm, verbose = verbose)
        }
    }
    else if (bg == "z") {
        seq.len = sapply(sequences, length)
        pwm.len = sapply(pwms, length)
        res$sequence.bg = cutoffZscore(res$sequence.nobg, seq.len, 
            pwm.len, pwmobj@bg.P)
        res$group.bg = cutoffZscoreSequenceSet(res$sequence.nobg, 
            seq.len, pwm.len, pwmobj@bg.P)
    }
    else if (bg == "pval") {
        seq.len = sapply(sequences, length)
        pwm.len = sapply(pwms, length)
        usecutoff = NULL
        if (score == "cutoff") 
            usecutoff = cutoff
        if (!group.only) {
            res$sequence.bg = t(sapply(1:length(seq.len), function(i) empiricalPvalue(res$sequence.nobg[i, 
                ], seq.len[i], pwm.len, pwmobj@bg.fwd, pwmobj@bg.rev, 
                cutoff = usecutoff, B = B, verbose = verbose)))
        }
        if (score == "clover") 
            res$group.bg = cloverPvalue1seq(res$sequence.nobg, 
                seq.len, pwm.len, pwmobj@bg.fwd, pwmobj@bg.rev, 
                B = B, verbose = verbose, clover = res$group.nobg)
        else res$group.bg = empiricalPvalueSequenceSet(res$sequence.nobg, 
            seq.len, pwm.len, pwmobj@bg.fwd, pwmobj@bg.rev, cutoff = usecutoff, 
            B = B, verbose = verbose)
    }
    else if (bg == "ms") {
        usecutoff = NULL
        if (score == "cutoff") 
            usecutoff = cutoff
        res$sequence.bg = matrixShuffleZscorePerSequence(res$sequence.nobg, 
            sequences, pwms, cutoff = usecutoff, B = motif.shuffles)
    }
    else if (bg == "gev") {
        seq.len = sapply(sequences, length)
        pwm.len = sapply(pwms, length)
        res$sequence.bg = gevPerSequence(res$sequence.nobg, seq.len, 
            pwm.len, pwmobj@bg.loc, pwmobj@bg.scale, pwmobj@bg.shape)
        res$group.bg = NULL
    }
    else {
        stop(paste("Uknown background correction algorithm: '", 
            bg, "', Please select one of: 'none', 'logn', 'z', 'pval', 'ms'", 
            sep = ""))
    }
    if (group.only) {
        seq.n = grep("^sequence[.]", names(res))
        if (length(seq.n) > 0) {
            res = res[-seq.n]
        }
    }
    if ("sequence.nobg" %in% names(res)) {
        rownames(res$sequence.nobg) = names(sequences)
    }
    if ("sequence.bg" %in% names(res)) {
        rownames(res$sequence.bg) = names(sequences)
    }
    return(new("MotifEnrichmentResults", res = res))
}

scanWithPWM2=function (pwm, dna, pwm.rev = NULL, odds.score = FALSE, both.strands = FALSE, 
    strand.fun = "mean") 
{
    if (is.character(dna)) 
        dna = DNAString(dna)
    if (!(class(dna) %in% c("DNAString", "DNAStringSet"))) 
        stop("The input sequence needs to be either of type DNAString or DNAStringSet")
    if (is.null(pwm.rev)) 
        pwm.rev = reverseComplement(pwm)
    pwm = pwm$pwm
    #unchanged to be the same
    pwm.rev = pwm.rev$pwm
    if (length(dna) < ncol(pwm)) {
        stop("DNA sequence needs to be at least as long as the PWM")
    }
    fwd.motif = PWMscoreStartingAt(pwm, dna, starting.at = 1:(length(dna) - 
        ncol(pwm) + 1))
    #setting to NULL prevent scores on the rev strand
     back.motif=0
    #back.motif = PWMscoreStartingAt(pwm.rev, dna, starting.at = 1:(length(dna) - 
        #ncol(pwm) + 1))
    if (both.strands) {
        res = cbind(fwd.motif, back.motif)
        colnames(res) = c("fwd", "rev")
        res = rbind(res, matrix(NA, nrow = (ncol(pwm) - 1), ncol = 2))
    }
    else {
        if (strand.fun == "max") {
            res = apply(cbind(fwd.motif, back.motif), 1, max)
        }
        else if (strand.fun == "mean") {
            res = 2^cbind(fwd.motif, back.motif)
            res = log2(rowMeans(res))
        }
        else {
            stop("Unknown strand function", strand.fun, ". Valid values are: mean, max")
        }
        res = c(res, rep(NA, ncol(pwm) - 1))
    }
    if (odds.score) 
        return(2^res)
    else return(res)
}
