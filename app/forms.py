import re

from flask_wtf import FlaskForm
from wtforms import SelectField, StringField, SubmitField, TextAreaField
from wtforms.validators import DataRequired, Email, Length, ValidationError


class ContactForm(FlaskForm):
    name = StringField(
        "Full Name",
        validators=[
            DataRequired(message="Name is required"),
            Length(min=2, max=50, message="Name must be between 2 and 50 characters"),
        ],
    )

    email = StringField(
        "Email",
        validators=[
            DataRequired(message="Email is required"),
            Email(message="Please enter valid email address"),
        ],
    )

    subject = SelectField(
        "Subject",
        choices=[
            ("general", "General Inquiry"),
            ("support", "Support Request"),
            ("feedback", "Feedback"),
            ("other", "Other"),
        ],
        validators=[DataRequired()],
    )

    message = TextAreaField(
        "Message",
        validators=[
            DataRequired(message="Message is required"),
            Length(
                min=10, max=500, message="Message must be between 10 and 500 characters"
            ),
        ],
    )

    submit = SubmitField("Send Message")

    def validate_name(self, name):
        if not re.match("^[a-zA-Z\s]+$", name.data):
            raise ValidationError("Name must contain only letters and spaces")


class NewsletterForm(FlaskForm):
    email = StringField(
        "Email",
        validators=[
            DataRequired(message="Email is required"),
            Email(message="Please enter valid email address"),
        ],
    )

    submit = SubmitField("Subscribe")
