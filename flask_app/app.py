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
    return render_template("home.html")



##### @TODO: input all directories
# consider short & long forms
# consider outputting user data to PostgreSQL db and storing for evaluation on app in dashboard
# (Model scores, user inputs, # of applications)
# consider visual of how applicant compares to others






# crunching user input for approval
@app.route("/form_submit", methods=['POST'])
def crunch():

    ### DEV TOOLS ###
    field_list=['items']


    form_data = {}

    '''@TODO: 

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
