# Generated by Django 4.0.4 on 2022-08-02 10:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('subscription', '0003_operation_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='operation',
            name='status',
            field=models.CharField(choices=[(1, 'come'), (2, 'not come'), (3, 'no reason')], default=1, max_length=20),
        ),
    ]
