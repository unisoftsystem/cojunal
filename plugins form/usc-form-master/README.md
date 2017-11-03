# usc-form
Form builder

## Install
```javascript
$ git clone https://github.com/wilmaribg/usc-form.git 
$ cd usc-form
$ npm i
$ gulp
```

### Nota:
Usar:
* [datalist](https://www.w3schools.com/html/tryit.asp?filename=tryhtml_elem_datalist)
* [HTML5 Input Types](https://www.w3schools.com/html/html_form_input_types.asp)

## Basic input properties
```javascript
field: {
  name: {
    type: 'text | password | email | number | search | tel | textarea | checkbox | html | button | datetime | submit',
    icon: ''
    color: ''
    minHeight: '12' // Only apply in textarea (rem)
    col: 25 // Set width value in percent (max 100) 
    showDelete: true/false // Only image type
    validate: {
      errorMessage
      min
      max
      minLength
      maxLength
      pattern
    }
  }
}

// Note: html input not validate data
```

## Input Radio and Select
configuración para un campo radio o select agregar la validacion
```javascript
field: {
  name: {
    "type": "select",
    "label": "Select you city",
    "multiple": "true",
    "col": 25 // Set width value in percent (max 100) 
    "okText": "Aceptar", //Only select field
    "cancelText": "Aceptar", //Only select field
    "enum": [
      ["ca", "Cartago"],
      ["pe", "Pereira"],
      ["med", "Medellín"]
    ]
  }
}
```

## Usage
```html
<!--  data-source: JSON del formulario -->
<!--  end-point: url a al que se va a hacer la petición POST -->
<!--  submit-success: callback de respuesta del form -->
<usc-form data-source= ""end-point= ""submit-success= "">
</usc-form>
```

