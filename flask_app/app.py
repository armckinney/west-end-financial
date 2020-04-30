'''
Houston Flask App
Author: Andrew McKinney
Creation Date: 2020-02-14
'''

# Import Dependencies
from flask import Flask, render_template, request
from models import credit_crunch


### DEV TOOLS ###
dev_mode = True


# Flask App Setup
app = Flask(__name__)





#################################################
# Flask Routes
#################################################


@app.route("/")
def index():
    return render_template("index.html")

@app.route("/data_analysis.html")
def data_analysis():
    return render_template("data_analysis.html")

@app.route("/about_us.html")
def about_us():
    return render_template("about_us.html")


@app.route("/model_comparison.html")
def model_comparison():
    return render_template("model_comparison.html")


@app.route("/neural_network_code.html")
def neural_network_code():
    return render_template("neural_network_code.html")


@app.route("/neural_network.html")
def neural_network():
    return render_template("neural_network.html")

@app.route("/random_forest_code.html")
def random_forest_code():
    return render_template("random_forest_code.html")


@app.route("/random_forest.html")
def random_forest():
    return render_template("random_forest.html")




##### @TODO: input all directories
# consider short & long form selection
# consider outputting user data to PostgreSQL db and storing for evaluation on app in dashboard
# (Model scores, user inputs, # of applications)
# consider visual of how applicant compares to others







# crunching user input for approval
@app.route("/form_submit", methods=['POST'])
def crunch():

    ### DEV TOOLS ###
    field_list = ['CHK_ACCT', 'DURATION', 'HISTORY', 'NEW_CAR', 'USED_CAR', 'FURNITURE', 'RADIO_TV', 'EDUCATION', 'RETRAINING',
    'AMOUNT', 'SAV_ACCT', 'EMPLOYMENT', 'INSTALL_RATE', 'MALE_DIV', 'MALE_SINGLE', 'MALE_MAR_or_WID', 'CO_APPLICANT', 'GUARANTOR', 
    'PRESENT_RESIDENT', 'REAL_ESTATE', 'PROP_UNKN_NONE', 'AGE', 'OTHER_INSTALL', 'RENT', 'OWN_RES', 'NUM_CREDITS', 'JOB', 
    'NUM_DEPENDENTS', 'TELEPHONE', 'FOREIGN']


    form_data = {}

    '''@TODO: input form actions and method

    # for inputs in html:
    <form action="{{ url_for('form_submit') }}" method="post">
        <input type="text" name="projectFilepath">
        <input type="submit">
    </form>

    '''

    # packing form_data from field list
    for field in field_list:
        form_data[field] = request.form[field]


    # @TODO convert inputs to required format for TF (note can either call function to convert on request item or can loop through form_data to convert)
    converted_data = "some data stored a field:value dictionary"
    

    # returning approval rating for user
    crunchies = credit_crunch(converted_data)

    return render_template("crunch_results.html", crunchies=crunchies)



if __name__ == "__main__":
    if dev_mode:
        app.run(debug=True)
