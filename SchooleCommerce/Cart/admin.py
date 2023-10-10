from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register(Cart)
admin.site.register(ProductQuantity)
admin.site.register(CartProductList)
admin.site.register(Checkout)