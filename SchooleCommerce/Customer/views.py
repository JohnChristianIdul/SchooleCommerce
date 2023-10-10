from django.http import HttpResponse
from django.shortcuts import render


# Create your views here.
def index(request):
    template = loader.get_template('register.html')
    return HttpResponse(template.render())

