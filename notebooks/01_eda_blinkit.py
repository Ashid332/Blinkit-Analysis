"""
Blinkit Analysis: Exploratory Data Analysis (EDA)
=====================================================

This script performs comprehensive exploratory data analysis on the Blinkit grocery dataset.
It demonstrates data cleaning, aggregation, and visualization techniques using Pandas and NumPy.

Author: Data Analytics Portfolio
Date: 2025
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Set display options
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)

# Load the dataset
print("Loading data...")
df = pd.read_excel('BlinkIT Grocery Data.xlsx')
print(f"Dataset shape: {df.shape}")
print(f"\nColumn names and types:")
print(df.dtypes)

# Data Cleaning
print("\n" + "="*50)
print("DATA CLEANING")
print("="*50)

# Clean column names
df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')

# Check for missing values
print(f"\nMissing values:\n{df.isnull().sum()}")

# Data Overview
print("\n" + "="*50)
print("DATA OVERVIEW")
print("="*50)
print(f"\nBasic statistics:\n{df.describe()}")

# Revenue Analysis by Outlet Type
print("\n" + "="*50)
print("REVENUE ANALYSIS BY OUTLET TYPE")
print("="*50)

revenue_by_outlet = df.groupby('outlet_type')['item_outlet_sales'].agg([
    ('total_sales', 'sum'),
    ('avg_sales', 'mean'),
    ('median_sales', 'median'),
    ('std_dev', 'std'),
    ('transaction_count', 'count')
]).round(2).sort_values('total_sales', ascending=False)

print(f"\n{revenue_by_outlet}")

# Product Category Analysis
print("\n" + "="*50)
print("PRODUCT CATEGORY ANALYSIS")
print("="*50)

category_analysis = df.groupby('item_type')['item_outlet_sales'].agg([
    ('total_sales', 'sum'),
    ('avg_sales', 'mean'),
    ('product_count', 'count')
]).round(2).sort_values('total_sales', ascending=False).head(10)

print(f"\nTop 10 categories:\n{category_analysis}")

# Fat Content Impact
print("\n" + "="*50)
print("FAT CONTENT IMPACT ANALYSIS")
print("="*50)

fat_analysis = df.groupby('item_fat_content')['item_outlet_sales'].agg([
    ('total_sales', 'sum'),
    ('avg_sales', 'mean'),
    ('median_sales', 'median'),
    ('count', 'count')
]).round(2)

print(f"\n{fat_analysis}")

# Visibility Impact on Sales
print("\n" + "="*50)
print("VISIBILITY IMPACT ANALYSIS")
print("="*50)

visibility_impact = df.groupby(
    pd.cut(df['item_visibility'], bins=5, labels=['Very Low', 'Low', 'Medium', 'High', 'Very High'])
)['item_outlet_sales'].agg(['mean', 'count']).round(2)

print(f"\n{visibility_impact}")

# Location Type Analysis
print("\n" + "="*50)
print("LOCATION TYPE ANALYSIS")
print("="*50)

location_analysis = df.groupby('outlet_location_type')['item_outlet_sales'].agg([
    ('total_sales', 'sum'),
    ('avg_sales', 'mean'),
    ('count', 'count')
]).round(2).sort_values('total_sales', ascending=False)

print(f"\n{location_analysis}")

# Outlet Size Analysis
print("\n" + "="*50)
print("OUTLET SIZE ANALYSIS")
print("="*50)

size_analysis = df.groupby('outlet_size')['item_outlet_sales'].agg([
    ('total_sales', 'sum'),
    ('avg_sales', 'mean'),
    ('count', 'count')
]).round(2).sort_values('total_sales', ascending=False)

print(f"\n{size_analysis}")

# Correlation Analysis
print("\n" + "="*50)
print("CORRELATION ANALYSIS")
print("="*50)

# Select numeric columns
numeric_cols = df.select_dtypes(include=[np.number]).columns
corr_matrix = df[numeric_cols].corr()

print(f"\nCorrelation with item_outlet_sales:")
print(corr_matrix['item_outlet_sales'].sort_values(ascending=False))

print("\n" + "="*50)
print("ANALYSIS COMPLETE")
print("="*50)
