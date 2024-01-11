# -*- coding: utf-8 -*-
"""
Created on Thu Oct 19 13:49:26 2023 
"""
import numpy as np
import tensorflow as tf
from tensorflow import keras
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from tensorflow.keras.callbacks import EarlyStopping

#%%
# Generate synthetic dataset for classification
X, y = make_classification(n_samples=1000, n_features=20, n_classes=2, random_state=42)

#%%
# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

#%%
# Build the neural network model
model = keras.Sequential([
    keras.layers.Dense(12, activation='relu', input_shape=(X_train.shape[1],)),
    keras.layers.Dense(5, activation='relu'),
    keras.layers.Dense(2, activation='sigmoid')
])

#%%
# Compile the model
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy']) #usada el 99% de las veces

#%%
# Extra
# Early stopping callback
early_stopping = EarlyStopping(monitor='val_loss', patience=15)

#%%
# Train the model with early stopping  # cambias el batch dependiendo de lo rapido que lo necesites ya que entre mayor cantidad de datos necesitas un batch mayor ya que si no tardara mucho tiempo
history = model.fit(X_train, y_train, epochs=60, batch_size = 2\
                    ,validation_split=0.2, callbacks=[early_stopping])

#%%
# Evaluate the model
test_loss, test_acc = model.evaluate(X_test, y_test)

#%%
# Print the test accuracy
print('Test accuracy:', test_acc)

#%%
# Plotting cross-validation loss
plt.plot(history.history['loss'], label='Training Loss')
plt.plot(history.history['val_loss'], label='Validation Loss')
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.legend()
plt.show()


#%% View the training performance
import matplotlib.pyplot as plt
fig = plt.figure(figsize=(20,10))
plt.subplot(121)
plt.plot(history.history['loss'])
plt.xlabel('Epochs'),plt.ylabel('Loss function')
plt.subplot(122)
plt.plot(history.history['accuracy'])
plt.xlabel('Epochs'),plt.ylabel('Accuracy function')
#%%
# Evaluate the model
test_loss, test_acc = model.evaluate(X_test, y_test)

#%%
# Print the test accuracy
print('Test accuracy:', test_acc)
