from django.forms import ModelForm
from django.db import connection
from django import forms
from .models import Customer


class CustomerRegisterForm(ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    name = forms.CharField(widget=forms.TextInput)
    address = forms.CharField(widget=forms.TextInput)
    email = forms.EmailField(widget=forms.TextInput)
    contact_number = forms.CharField(widget=forms.TextInput)
    person_type = 'C'
    customer_wallet = 0.0

    class Meta:
        model = Customer
        fields = ['username', 'password', 'name', 'address', 'email', 'contact_number',
                  'school_admin']
        labels = {
            'school_admin': 'School Name',
        }

    def save_with_stored_procedure(self):
        cleaned_data = self.cleaned_data

        args = [
            cleaned_data['username'],
            cleaned_data['password'],
            cleaned_data['name'],
            cleaned_data['address'],
            cleaned_data['email'],
            int(cleaned_data['contact_number']),
            self.person_type,
            self.customer_wallet,
            cleaned_data['school_admin'].school_admin_ID,
            None  # Placeholder for the output parameter
        ]

        cursor = connection.cursor()

        # Call your modified stored procedure
        cursor.callproc('insertCustomer', args)

        # Fetch the result set after calling the stored procedure
        result_set = cursor.fetchall()

        # Retrieve the output parameter value from the result set
        output_parameter_value = result_set[0][1] if result_set else None

        # Commit the transaction
        connection.commit()

        # Close the cursor
        cursor.close()

        return output_parameter_value


class CustomerLoginForm(ModelForm):
    class Meta:
        model = Customer
        fields = ['username', 'password']

