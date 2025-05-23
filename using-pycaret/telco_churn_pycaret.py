# -*- coding: utf-8 -*-
"""telco-churn-pycaret.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1dE05fkTwmux5BfyXR3JeP0odjfvgymjz
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv('telco-customer-churn.csv', sep=',')

df.head()

# Tampilkan informasi dasar
print("Info Dataset:")
print(df.info())
print("\nContoh Data (5 baris pertama):")
print(df.head())
print("\nStatistik Deskriptif:")
print(df.describe())

df['TotalCharges'] = pd.to_numeric(df['TotalCharges'], errors='coerce')
print(df['TotalCharges'].isnull().sum())  # Cek ada berapa null setelah konversi

df = df.dropna(subset=['TotalCharges'])
print(df['TotalCharges'].isnull().sum())  # Cek ada berapa null setelah konversi

# Cek missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Distribusi target (Churn)
plt.figure(figsize=(6,4))
sns.countplot(x='Churn', data=df)
plt.title('Distribusi Churn')
plt.show()

# Distribusi fitur numerik
numeric_cols = ['tenure', 'MonthlyCharges', 'TotalCharges']
for col in numeric_cols:
    plt.figure(figsize=(6,4))
    sns.histplot(df[col], kde=True)
    plt.title(f'Distribusi {col}')
    plt.show()

"""**Data Cleaning dan Exploratory Data Analysis (EDA)**"""

# Drop kolom tidak relevan
df = df.drop('customerID', axis=1)

# Konversi target Churn ke biner (0/1)
df['Churn'] = df['Churn'].map({'No': 0, 'Yes': 1})

# EDA: Korelasi fitur numerik
plt.figure(figsize=(8,6))
sns.heatmap(df[numeric_cols + ['Churn']].corr(), annot=True, cmap='coolwarm')
plt.title('Korelasi Fitur Numerik dengan Churn')
plt.show()

# EDA: Hubungan fitur kategorikal dengan Churn
categorical_cols = ['gender', 'Contract', 'InternetService', 'PaymentMethod']
for col in categorical_cols:
    plt.figure(figsize=(8,4))
    sns.countplot(x=col, hue='Churn', data=df)
    plt.title(f'Hubungan {col} dengan Churn')
    plt.xticks(rotation=45)
    plt.show()

# Simpan dataset yang sudah dibersihkan
df.to_csv('cleaned_telco_data.csv', index=False)

"""**Feature Engineering** \
Tujuan: Membuat fitur baru dan mempersiapkan data untuk modeling.
"""

# Feature engineering: Buat fitur baru
df['AvgMonthlyCharges'] = df['TotalCharges'] / (df['tenure'] + 1)  # Hindari pembagian dengan 0

# One-Hot Encoding untuk fitur kategorikal
categorical_cols = ['gender', 'Partner', 'Dependents', 'PhoneService', 'MultipleLines',
                    'InternetService', 'OnlineSecurity', 'OnlineBackup', 'DeviceProtection',
                    'TechSupport', 'StreamingTV', 'StreamingMovies', 'Contract', 'PaperlessBilling',
                    'PaymentMethod']
df = pd.get_dummies(df, columns=categorical_cols, drop_first=True)

from sklearn.preprocessing import StandardScaler # Import StandardScaler

# Skalasi fitur numerik
scaler = StandardScaler()
numeric_cols = ['tenure', 'MonthlyCharges', 'TotalCharges', 'AvgMonthlyCharges']
df[numeric_cols] = scaler.fit_transform(df[numeric_cols])

# Simpan dataset yang sudah diproses
df.to_csv('processed_telco_data.csv', index=False)

"""**Modeling dengan PyCaret (Classification)** \
Tujuan: Membangun model klasifikasi menggunakan PyCaret untuk memprediksi churn.
"""

from pycaret.classification import *
import pandas as pd

# Setup PyCaret
clf = setup(data=df, target='Churn', session_id=123, normalize=True,
            remove_multicollinearity=True, multicollinearity_threshold=0.95)

# Bandingkan model
best_model = compare_models()

# Latih model terbaik
final_model = finalize_model(best_model)

# Simpan model
save_model(final_model, 'best_churn_model')

"""**Hyperparameter Tuning** \
Tujuan: Mengoptimalkan performa model terbaik dengan tuning hyperparameter.
"""

# Load model terbaik
model = load_model('best_churn_model')

# Tuning hyperparameter
tuned_model = tune_model(model, optimize='F1', n_iter=10)

# Simpan model yang sudah dituning
save_model(tuned_model, 'tuned_churn_model')

"""**Model Evaluation & Explainability** \
Tujuan: Mengevaluasi performa model dan menjelaskan prediksi menggunakan SHAP.
"""

# Load model yang sudah dituning
model = load_model('tuned_churn_model')

# Evaluasi model
evaluate_model(model)

# Prediksi pada data training
predictions = predict_model(model)

# test_model.py

import pandas as pd
from pycaret.classification import load_model, predict_model
from sklearn.metrics import classification_report # Import classification_report explicitly

# Step 1: Load Model
model = load_model('tuned_churn_model')
print("✅ Model berhasil diload.")

# Step 2: Load Dataset untuk Testing
# (bisa pakai dataset baru atau dataset lama yang sudah diproses)
test_df = pd.read_csv('processed_telco_data.csv')

# Step 3: Prediksi
predictions = predict_model(model, data=test_df)

# Step 4: Simpan hasil prediksi ke CSV
predictions.to_csv('churn_predictions.csv', index=False)
print("✅ Prediksi selesai dan disimpan ke 'churn_predictions.csv'")

# Step 5: Cek performa ringkas (kalau ada kolom 'Churn' untuk validasi)
if 'Churn' in test_df.columns:
    y_true = test_df['Churn']
    # Use the predicted 'Label' column instead of the continuous 'prediction_score'
    y_pred = predictions['prediction_label']

    print("📊 Classification Report:")
    print(classification_report(y_true, y_pred))

# Optional: Lihat 10 prediksi pertama
print("\n🧪 Contoh hasil prediksi:")
print(predictions[['Churn', 'prediction_label', 'prediction_score']].head(10))