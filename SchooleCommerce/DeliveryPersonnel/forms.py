from django.forms import ModelForm
from django.db import connection
from django import forms
from .models import *
from Cart.models import Order


class DeliveryPersonnelRegFrm(ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    name = forms.CharField(widget=forms.TextInput)
    address = forms.CharField(widget=forms.TextInput)
    email = forms.EmailField(widget=forms.TextInput)
    contact_number = forms.CharField(widget=forms.TextInput)
    person_type = 'D'

    class Meta:
        model = DeliveryPersonnel
        fields = ['username', 'password', 'name', 'address', 'email', 'contact_number']


class DeliveryPersonnelLoginFrm(ModelForm):
    class Meta:
        model = DeliveryPersonnel
        fields = ['username', 'password']


class CourierRegFrm(ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    name = forms.CharField(widget=forms.TextInput)
    address = forms.CharField(widget=forms.TextInput)
    email = forms.EmailField(widget=forms.TextInput)
    contact_number = forms.CharField(widget=forms.TextInput)
    person_type = 'T'

    class Meta:
        model = DeliveryPersonnel
        fields = ['username', 'password', 'name', 'address', 'email', 'contact_number']


class CourierLoginFrm(ModelForm):
    class Meta:
        model = DeliveryPersonnel
        fields = ['username', 'password']


class CourierOrderDpForm(forms.ModelForm):
    class Meta:
        model = CourierOrderDp
        fields = ['delivery_personnel_ID', 'order_ID', 'est_delivery_date']

    def __init__(self, *args, **kwargs):
        super(CourierOrderDpForm, self).__init__(*args, **kwargs)
        # Add any additional customization for the form if needed

        # Set the est_delivery_date field to use a DateInput widget
        self.fields['est_delivery_date'].widget = forms.DateInput(attrs={'type': 'date'})



# class UpdateOrderStatusForm(ModelForm):
#     class Meta:
#         model = CourierOrderDp
#         fields = ['order_ID', 'delivery_status']

# class CourierOrderDpForm(forms.ModelForm):
#     class Meta:
#         model = CourierOrderDp
#         fields = ['courier_ID', 'delivery_personnel', 'order', 'delivery_date', 'commission']
#
#     def __init__(self, *args, **kwargs):
#         super(CourierOrderDpForm, self).__init__(*args, **kwargs)
#
#         # Use ModelChoiceField for orders and delivery personnel with queryset
#         self.fields['order'].queryset = Order.objects.all()
#         self.fields['delivery_personnel'].queryset = DeliveryPersonnel.objects.all()
#         self.fields['courier_ID'].queryset = Courier.objects.all()
#

# class DpOsUpdateForm(forms.ModelForm):
#     class Meta:
#         model = DpOsUpdate
#         fields = ['delivery_personnel_ID', 'order', 'delivery_status']  # Include 'delivery_personnel_ID' in the fields
#
#     def __init__(self, *args, **kwargs):
#         # Accept 'delivery_personnel_id' as a parameter
#         delivery_personnel_id = kwargs.pop('delivery_personnel_id', None)
#         super().__init__(*args, **kwargs)
#
#         # Set the initial value for delivery_personnel_ID
#         self.fields['delivery_personnel_ID'].initial = delivery_personnel_id
#
#     def clean_delivery_personnel_ID(self):
#         # Ensure that delivery_personnel_ID is not changed during form submission
#         return self.instance.delivery_personnel_ID