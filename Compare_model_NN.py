# -*- coding: utf-8 -*-
"""
Created on Thu Oct 19 14:25:01 2023

"""
import numpy as np
import tensorflow as tf
from tensorflow import keras
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, roc_curve, auc
import matplotlib.pyplot as plt
from tensorflow.keras.callbacks import EarlyStopping

#%%
# Generate complex synthetic dataset for multi-output classification
X, y = make_classification(n_samples=1000, n_features=20, n_informative=15, n_classes=3, n_clusters_per_class=2, weights=[0.1, 0.3, 0.6], random_state=42)
y = keras.utils.to_categorical(y, 3)

# Split the dataset
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

#%%
# Neural Network Model
nn_model = keras.Sequential([
    keras.layers.Dense(128, activation='relu', input_shape=(X_train.shape[1],)),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(3, activation='softmax')
])

nn_model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

history_nn = nn_model.fit(X_train, y_train, epochs=50, validation_split=0.2)
#%%
# Logistic Regression Model
lr_model = LogisticRegression(multi_class='multinomial')
lr_model.fit(X_train, np.argmax(y_train, axis=1))
#%%
# Support Vector Machine Model
svm_model = SVC()
svm_model.fit(X_train, np.argmax(y_train, axis=1))
#%%
# Evaluate Models

# Accuracy for Logistic Regression and SVM
lr_pred = lr_model.predict(X_test)
svm_pred = svm_model.predict(X_test)
acc_lr = accuracy_score(np.argmax(y_test, axis=1), lr_pred)
acc_svm = accuracy_score(np.argmax(y_test, axis=1), svm_pred)
_, nn_metrics = nn_model.evaluate(X_test, y_test)

print('Accuracy LR:', acc_lr)
print('Accuracy SVM:', acc_svm)
print('NN Test Metrics:', nn_metrics)

