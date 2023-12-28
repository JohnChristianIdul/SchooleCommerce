# Generated by Django 4.2.7 on 2023-12-28 17:43

import datetime
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('cart_ID', models.AutoField(primary_key=True, serialize=False)),
                ('quantity', models.IntegerField()),
                ('price', models.FloatField()),
                ('subtotal', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Checkout',
            fields=[
                ('checkout_ID', models.AutoField(primary_key=True, serialize=False)),
                ('total_amount', models.FloatField()),
                ('payment_method', models.CharField(choices=[('GCash', 'GCash'), ('Online Bank', 'Online Bank'), ('CoD', 'Cash on Delivery')], max_length=20)),
                ('receive_by_date', models.DateField(default=datetime.datetime(2024, 1, 5, 1, 43, 34, 684980))),
                ('order_date', models.DateField(verbose_name=datetime.datetime(2023, 12, 29, 1, 43, 34, 684980))),
                ('confirm_order', models.BooleanField(default=False)),
                ('cart', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Cart.cart')),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('order_ID', models.AutoField(primary_key=True, serialize=False)),
                ('checkout', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Cart.checkout')),
            ],
        ),
        migrations.CreateModel(
            name='OrderStatus',
            fields=[
                ('order_status_ID', models.BigAutoField(primary_key=True, serialize=False)),
                ('order_status_change', models.DateTimeField()),
                ('order_status', models.CharField(choices=[('Order Placed', 'Order Placed'), ('Order Confirmed', 'Order Confirmed'), ('Order Preparing', 'Order Preparing'), ('Order Packaging', 'Order Packaging')], max_length=30)),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Cart.order')),
            ],
        ),
    ]