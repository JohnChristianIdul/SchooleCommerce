# Generated by Django 4.2.7 on 2023-12-28 17:43

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Product', '0004_alter_productreview_review_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='productreview',
            name='review_date',
            field=models.DateField(default=datetime.datetime(2023, 12, 29, 1, 43, 51, 984137)),
        ),
    ]
