'''
Credit Crunch
Author: Andrew McKinney
Creation Date: 2020-04-28
'''




def credit_crunch(converted_data):
# Credit Crunch is a TensorFlow Neural Network that predicts an applicant's probablity to default on a loan. 
# If default is predicted, a loan denial is returned; otherwise, approved.
# The NN model is dynamically created everytime to match in input data that is imported as a key:value dictionary.
# Generic NN model parameters can be set in the DEV TOOLS.


    ### DEV TOOLS ###
    numpy_seed = 42
    number_inputs = bundled_data.length()
    number_classes = 2
    number_hidden_layers = 2
    number_hidden_nodes = 100
    number_epochs = 50
    layer_activation = 'relu'
    classifier_activation = 'softmax'
    learn_metrics = ['accuracy']
    loss_type = 'categorical_crossentropy'
    optimizer_type = 'adam'



    # import dependencies
    import numpy as np
    import pandas as pd
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import LabelEncoder, MinMaxScaler
    from tensorflow.keras.utils import to_categorical
    from tensorflow.keras.models import Sequential
    from tensorflow.keras.layers import Dense



    # setting numpy seed for reproducible results
    np.random.seed(numpy_seed)


    # import train data
    raw_data = pd.read_csv('datasets/Credit_Data_Raw.csv')

    raw_data.dropna()

    # defining labels and input fields
    X = raw_data.drop('DEFAULT', axis=1)[[item for item in converted_data]]
    y = raw_data['DEFAULT'].reshape(-1, 1)

    # spliting data to test and training sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=42)

    # scaling data 
    X_scaler = MinMaxScaler().fit(X_train)
    X_train_scaled = X_scaler.transform(X_train)
    X_test_scaled = X_scaler.transform(X_test)
    data_bundle = X_scaler.transform(np.array(list([converted_data[item] for item in converted_data])))

    # one-hot-encoding output labels
    label_encoder = LabelEncoder()
    label_encoder.fit(y_train)
    encoded_y_train = label_encoder.transform(y_train)
    encoded_y_test = label_encoder.transform(y_test)
    y_train_categorical = to_categorical(encoded_y_train)
    y_test_categorical = to_categorical(encoded_y_test)

    # instantiating Neural Net Model
    model = Sequential()

    # adding input layer
    model.add(Dense(units=number_hidden_nodes, activation=layer_activation, input_dim=number_inputs))

    # adding hidden layers
    for layer in np.array(0, number_hidden_layers):
        model.add(Dense(units=number_hidden_nodes, activation=layer_activation)

    # adding classifier layer
    model.add(Dense(units=number_classes, activation=classifier_activation))

    # compiling model
    model.compile(optimizer=optimizer_type, loss=loss_type, metrics=learn_metrics)

    # fitting model to training data
    model.fit(
        X_train_scaled,
        y_train_categorical,
        epochs=number_epochs,
        shuffle=True,
        verbose=0
    )


    # predicting approval for user
    crunchies = model.predict(data_bundle)

    # @TODO: return model evaluation for dashboard?
    # Model Evaluation
    # model_loss, model_accuracy = default_model.evaluate(X_test_scaled, y_test_categorical, verbose=2)


    return crunchies