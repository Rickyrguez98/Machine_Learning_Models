# -*- coding: utf-8 -*-
"""
Created on Thu Oct 19 14:12:01 2023
"""

import numpy as np
import tensorflow as tf
from tensorflow import keras
from sklearn.datasets import make_regression
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt
from tensorflow.keras.callbacks import EarlyStopping

#%%
# Generate synthetic dataset for regression
X, y = make_regression(n_samples=6000, n_features=20, noise=0.1, random_state=42)

#%%
# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

#%%
# Build the neural network model for regression
model = keras.Sequential([
    keras.layers.Dense(128, activation='relu', input_shape=(X_train.shape[1],)),
    keras.layers.Dense(64, activation='tanh'),
    keras.layers.Dense(1, activation='linear')
])

#%%
# Compile the model

model.compile(optimizer='adam',
              loss='mean_squared_error')

model.summary()

#%%
# Early stopping callback
early_stopping = EarlyStopping(monitor='val_loss', patience=5)

#%%
# Train the model with early stopping
history = model.fit(X_train, y_train, epochs=100, validation_split=0.2, callbacks=[early_stopping])

#%%
# Evaluate the model
test_loss = model.evaluate(X_test, y_test)

#%%
# Print the test loss
print('Test loss:', test_loss)

#%%
# Make predictions
y_pred = model.predict(X_test)

#%%
# Calculate R2 score
r2 = r2_score(y_test, y_pred)
print('R2 score:', r2)

#%%
# Plotting cross-validation loss
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.plot(history.history['loss'], label='Training Loss')
plt.plot(history.history['val_loss'], label='Validation Loss')
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.legend()

# Plotting real vs estimated values
plt.subplot(1, 2, 2)
plt.scatter(y_test, y_pred)
plt.xlabel('Real Values')
plt.ylabel('Predicted Values')
plt.title('Real vs Predicted Values')

plt.tight_layout()
plt.show()

