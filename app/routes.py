import logging

from flask import (
    Blueprint,
    flash,
    jsonify,
    redirect,
    render_template,
    request,
    url_for,
)
from itsdangerous import base64_encode
from wtforms.validators import email

from app.forms import ContactForm, NewsletterForm

bp = Blueprint("main", __name__)

# Configuring logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@bp.route("/")
def home():
    newsletter_form = NewsletterForm()
    return render_template("index.html", newsletter_form=newsletter_form)

@bp.route('/new')
def new():
    reurn render_template('new.html')

@bp.route('pricing')
def pricing():
    return render_template('pricing.html')

@bp.route("/contact", methods=["GET", "POST"])
def contact():
    form = ContactForm()
    
    if form.validate_on_submit():
        # process the form data
        name = form.name.data
        email = form.email.data
        subject = form.subject.data
        message = form.message.data
        
        # Imagine some validation and email sending logic here


        #Log the submission (in production, you might want to save this to a databaseor send an email)
        logger.info(f"Contact form submitted by {name} ({email}): - {subject}")

        # flash a success message
        flash(f'Thank you {name}! Your message has been sent.', 'success')

        return redirect(url_for('main.contact'))

    # Handle form errors
    if form.errors:
        for field, errors in form.errors.items():
            for error in errors:
                flash(f'{field.capitalize()} error: {error}', 'error')
    return render_template("contact.html", form=form)


@bp.route("/newsletter", methods=["POST"])
def newsletter():
    form = NewsletterForm()

    if form.validate_on_submit():
        email = form.email.data
        # Imagine some logic to add the email to a mailing list here
        logger.info(f"Newsletter Subscription: {email}')
        flash(f'Thank you? {email}! has been sumbscribed to the newsletter.', 'success')
    else:
        flash('please enter a valid email address.', 'error')

        return redirect(url_for('main.home'))
