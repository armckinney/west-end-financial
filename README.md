<!-- header -->
<div align="center">
    <p>
    <!-- Header -->
        <img width="100px" src="/images/About_us.jpg"  alt="west-end-financial" />
        <h2>Credit Crunch</h2>
        <p><i>by West End Financial</i></p>
    </p>
    <p>
    <!-- Shields -->
        <a href="https://github.com/armck-hub/west-end-financial/LICENSE">
            <img alt="License" src="https://img.shields.io/github/license/armck-hub/west-end-financial.svg" />
        </a>
        <a href="https://github.com/armck-hub/west-end-financial/actions">
            <img alt="Tests Passing" src="https://github.com/armck-hub/west-end-financial/workflows/CI/badge.svg" />
        </a>
        <a href="https://codecov.io/gh/armck-hub/west-end-financial">
            <img alt="Code Coverage" src="https://codecov.io/gh/armck-hub/west-end-financial/branch/master/graph/badge.svg" />
        </a>
        <a href="https://github.com/armck-hub/west-end-financial/issues">
            <img alt="Issues" src="https://img.shields.io/github/issues/armck-hub/west-end-financial" />
        </a>
        <a href="https://github.com/armck-hub/west-end-financial/pulls">
            <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/armck-hub/west-end-financial" />
        </a>
        <a href="https://stackshare.io/armck-hub/west-end-financial">
            <img alt="StackShare.io" src="http://img.shields.io/badge/tech-stack-0690fa.svg?label=StackShare.io">
        </a>
    </p>
    <p>
    <!-- Links -->
        <a href="https://westendfinancial.herokuapp.com/" target="_blank">View Demo</a>
        ·
        <a href="https://github.com/armck-hub/west-end-financial/issues/new/choose">Report Bug</a>
        ·
        <a href="https://github.com/armck-hub/west-end-financial/issues/new/choose">Request Feature</a>
    </p>
</div>
<br>
<br>

<!-- Description -->
Credit Crunch is a credit risk analysis web application built by the team at West End Financial.

The app utilizes various methods analysis, involves 2 key determination methods. One being a pre-developed neural network model that is utilized when the top 10 requested input fields are submitted and the other being a dynamic nerual network model that builds itself from a set of fields designated by the user.

##### Here's why Credit Crunch by West End Financial is important:
* It can lower your risk of financial credit lines given to your customers
* It can pre-approve your customers for a credit line
* It can enable cross-selling of other financial products such as savings and checking accounts
* It can reduce overhead and responsabilities of your Credit Loan Officers


### Building for Heroku
Heroku requires a `requirements.txt` in the root directory and Continuous Deployment is not configured for this repository. Thus, a manual dump of dependencies is required via executing `poetry export -f requirements.txt -o requirements.txt --without-hashes` prior to deploying on Heroku.
