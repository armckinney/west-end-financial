import os
from pathlib import Path

import uvicorn
from fastapi.applications import FastAPI
from fastapi.requests import Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from app.credit_crunch.models import approval_check, credit_crunch
from app.credit_crunch.utils import (
    basic_model_field_list,
    field_list,
    form_dict,
    general_field_list,
    merge_dict,
    packed_field_list,
    unpacking,
)

__ROOT_DIRECTORY = str(Path(__file__).parent)
os.environ["__ROOT_DIRECTORY"] = __ROOT_DIRECTORY

app = FastAPI(
    title="Credit Crunch",
    description="Credit Risk Analysis Web Application built on a Neural Net back-end",
)

app.mount(
    "/static",
    StaticFiles(directory=os.path.join(__ROOT_DIRECTORY, "static")),
    name="static",
)
templates = Jinja2Templates(directory=os.path.join(__ROOT_DIRECTORY, "templates"))


@app.get("/")
@app.get("/index.html")
def home(request: Request):
    return templates.TemplateResponse("index.html", context={"request": request})


@app.get("/data_analysis.html")
def data_analysis(request: Request):
    return templates.TemplateResponse(
        "data_analysis.html", context={"request": request}
    )


@app.route("/neural_network.html")
def neural_network(request: Request):
    return templates.TemplateResponse(
        "neural_network.html", context={"request": request}
    )


@app.route("/random_forest.html")
def random_forest(request: Request):
    return templates.TemplateResponse(
        "random_forest.html", context={"request": request}
    )


@app.route("/model_comparison.html")
def model_comparison(request: Request):
    return templates.TemplateResponse(
        "model_comparison.html", context={"request": request}
    )


@app.route("/about_us.html")
def about_us(request: Request):
    return templates.TemplateResponse("about_us.html", context={"request": request})


# crunching user input for approval
@app.route("/form_submit", methods=["POST"])
async def crunch(request: Request):

    # DEV TOOLS
    return_evaluation = True

    form = await request.form()

    try:
        # collecting standard items from form and making data dictionary if selection made
        general_form_data = form_dict(form, general_field_list)

        # collecting packed items from form and making data dictionary if selection made
        packed_form_data = form_dict(form, packed_field_list)

        # unpack the packs
        unpacked_form_data = unpacking(packed_form_data, packed_field_list)

        # appending unpacked data to general form data and sorting to model requirements
        data_package = merge_dict(field_list, general_form_data, unpacked_form_data)

        # determining to use basic or dynamic model based on user inputs
        if [item for item in data_package] == basic_model_field_list:
            basic_model = True
        else:
            basic_model = False

        # returning approval probability for user
        crunchies, model_loss, model_accuracy = credit_crunch(
            data_package, return_evaluation, basic_model
        )

        # determining approval status based on model accuracy and approval probability
        approval_status = approval_check(crunchies, model_accuracy)

        return templates.TemplateResponse(
            "credit_approval_results.html",
            context={"request": request, "approval_status": approval_status},
        )

    # Error handeling due to internal app error or due to incorrect inputs
    except Exception:
        return templates.TemplateResponse(
            "index_error.html", context={"request": request}
        )


if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
