# Generated by Django 4.2.7 on 2023-12-28 22:55

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Product', '0011_alter_productreview_review_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='productreview',
            name='review_date',
            field=models.DateField(default=datetime.datetime(2023, 12, 29, 6, 55, 9, 397661)),
        ),
    ]
