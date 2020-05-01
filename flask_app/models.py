'''
Credit Crunch
Author: Andrew McKinney
Creation Date: 2020-04-28
'''





def approval_check(crunchies, model_accuracy):
# approval_check determines the approval status of an applicant based on the approval probability and determining model accuracy
    
    # hard coding approval status variables
    sufficient_accuracy = 0.7
    pending_probability = 0.4
    approved_probability = 0.6

    # extracting approval probability from crunchies (class prediction probabilities); 
    # 1st value, [0], is approval probabilty
    # 2nd value, [1], is default probability
    approval_probability = crunchies[0][0]

    # determining approval status based on model accuracy and approval probability
    if model_accuracy > sufficient_accuracy:
        if approval_probability >= approved_probability:
            return("Approval")
        elif approval_probability >= pending_probability:
            return('Pending')
        else:
            return('Declined')
        
    else:
        if approval_probability >= approved_probability:
            return('Pending')
        else:
            return('Declined')






def credit_crunch(converted_data,  return_evaluation=False):
# Credit Crunch is a TensorFlow Neural Network that predicts an applicant's probablity to default on a loan. 
# If default is predicted, a loan denial is returned; otherwise, approved.
# The NN model is dynamically created everytime to match in input data that is imported as a key:value dictionary.
# return_evaluation should be a boolean value (true/false) on whether or not to return model evaluation metrics with function
# Generic NN model parameters can be set in the DEV TOOLS.


    ### DEV TOOLS ###
    return_model_evaluation = return_evaluation
    numpy_seed = 42
    number_inputs = len(converted_data)
    number_classes = 2
    number_hidden_layers = 1
    number_hidden_nodes = 60
    number_epochs = 30
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
    
    # defining labels, input fields, and input form data
    X = raw_data.drop('DEFAULT', axis=1)[[item for item in converted_data]]
    y = np.array(raw_data['DEFAULT']).reshape(-1, 1)
    data_bundle = np.array(list([converted_data[item] for item in converted_data])).reshape(1, -1)
    
    # spliting data to test and training sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=42)
    
    
    # scaling data 
    X_scaler = MinMaxScaler().fit(X_train)
    X_train_scaled = X_scaler.transform(X_train)
    X_test_scaled = X_scaler.transform(X_test)
    data_bundle_scaled = X_scaler.transform(data_bundle)
    
    
    # one-hot-encoding labels
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
    for layer in np.arange(0, number_hidden_layers):
        model.add(Dense(units=number_hidden_nodes, activation=layer_activation))

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


    # predicting approval for user (1st # is Approval Probability or 2nd # is Default Probability)
    crunchies = model.predict(data_bundle_scaled)

    
    # returning model evaluation if turned on
    if return_model_evaluation:
        model_loss, model_accuracy = model.evaluate(X_test_scaled, y_test_categorical, verbose=0)

        return crunchies, model_loss, model_accuracy

    else:

        return crunchies
