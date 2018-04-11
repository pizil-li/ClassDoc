from django import forms


class LiuyanForm(forms.Form):
    name = forms.CharField(required=True, label='Your name', max_length=20, min_length=3)
    email = forms.EmailField(required=True, label='email')
    address = forms.CharField(max_length=30, label='address')
    message = forms.CharField(max_length=60, label='message')
