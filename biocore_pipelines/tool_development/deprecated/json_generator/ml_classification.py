import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split

design_file = pd.read_table('Sample_DF_JR08-18.txt')

print(design_file.head())

map_sample_name = dict()