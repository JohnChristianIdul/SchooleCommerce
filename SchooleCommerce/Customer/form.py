from django.forms import ModelForm
from django import forms
from .models import Customer


class CustomerRegisterForm(ModelForm):
    username = forms.CharField(widget=forms.TextInput)
    password = forms.CharField(widget=forms.PasswordInput)
    name = forms.CharField(widget=forms.TextInput)
    address = forms.CharField(widget=forms.TextInput)
    email = forms.CharField(widget=forms.TextInput)
    contact_number = forms.CharField(widget=forms.TextInput)
    person_type = forms.CharField(widget=forms.HiddenInput, initial='C')
    customer_wallet = forms.FloatField(widget=forms.HiddenInput, initial=0.0)

    class Meta:
        model = Customer
        fields = ['customer_ID', 'username', 'password', 'name', 'address', 'email', 'contact_number', 'person_type',
                  'customer_wallet', 'school_admin_ID']


class CustomerLoginForm(ModelForm):
    username = forms.CharField(widget=forms.TextInput)
    password = forms.CharField(widget=forms.PasswordInput)

    class Meta:
        model = Customer
        fields = ['username', 'password']
