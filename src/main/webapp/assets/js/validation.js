function Validator(options){
    var selectorRules={};
    function validate(inputElement, rule) {

        var errorElement = inputElement.parentElement.querySelector(options.errorSelector);
        var errorMessage;
        var rules=selectorRules[rule.selector];
        for(var i = 0;i<rules.length;i++){
            // <input>
            errorMessage = rules[i](inputElement.value);
            // ckeditor
            if(inputElement.nodeName === 'TEXTAREA'){
                if (typeof editor !== 'undefined') {
                    let valEditor=editor.getData();
                    errorMessage =  rules[i](valEditor);
                    inputElement.value = valEditor;
                }else {
                    errorMessage = rules[i](inputElement.value);
                }
            }
            // <image>
            else if(inputElement.nodeName === 'IMG'){
                errorMessage =  rules[i](inputElement.src);
            }
            if(errorMessage) break;
        }
        if(errorMessage){
            errorElement.innerText = errorMessage;
            errorElement.style.color = 'red';
        }else{
            errorElement.innerText ='';
        }
        return !errorMessage;
    }
    var formElement = document.querySelector(options.form);
    if(formElement){
        formElement.onsubmit=function(e){
            e.preventDefault();
            var isFormValid=true;
            options.rules.forEach(function (rule) {
                var inputElement=formElement.querySelector(rule.selector);
                var isValid=validate(inputElement,rule);
                if(!isValid){
                     isFormValid=false;
                }
            });

            if(isFormValid){
                if(typeof options.onSubmit==='function'){
                    var obj = formElement;
                    var formData=new FormData();
                    $.each($(obj).find("input[type='file']"), function (i,tag) {
                        $.each($(tag)[0].files, function (i, file) {
                            formData.append(tag.name, file);
                        });
                    });

                    var params = $(obj).serializeArray();
                    $.each(params, function (i, v) {
                        formData.append(""+v.name+"", v.value);
                    });
                    options.onSubmit(formData);
                }
            }
        }
        options.rules.forEach(function (rule) {
            if(Array.isArray(selectorRules[rule.selector])){
                selectorRules[rule.selector].push(rule.test);
            }else{
                selectorRules[rule.selector]=[rule.test];
            }

            var inputElement = formElement.querySelector(rule.selector);
            if(inputElement){
                // <input>
                inputElement.onblur = function(){
                    validate(inputElement,rule);
                }
                inputElement.oninput=function () {
                    var errorElement = inputElement.parentElement.querySelector(options.errorSelector);
                    errorElement.innerText = '';
                }
                // <img>
                if(inputElement.nodeName === 'IMG'){
                    inputElement.onload = function () {
                        var errorElement = inputElement.parentElement.querySelector(options.errorSelector);
                        errorElement.innerText = '';
                    }
                }
            }
        })
    }
}
Validator.isRequired=function(selector){
    return {
        selector: selector,
        test: function (value) {
            return value.trim()?undefined:'This filed is not filled';
        }
    };
}
Validator.isEmail=function(selector){
    return {
        selector: selector,
        test: function (value) {
            var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            return regex.test(value)?undefined:'This filed must be a email';
        }
    };
}
Validator.isFormatPassword=function(selector){
    return {
        selector: selector,
        test: function (value) {
            var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{6,}$/;
            return regex.test(value)?undefined:'Password must have at least 6 characters and include letters, numbers and special characters';
        }
    };
}
Validator.isConfirmed=function(selector, getConfirmValue, message){
    return {
        selector: selector,
        test: function (value) {
            return value==getConfirmValue()?undefined: message||'The value entered is incorrect';
        }
    };
}



// Validator.isNumberGreaterEqualThan=function(selector, min){
//     return {
//         selector: selector,
//         test: function (value) {
//             return value >= min?undefined:'The value must >= '+ min;
//         }
//     };
// }
// Validator.isImageMiss=function(selector){
//     return {
//         selector: selector,
//         test: function (value) {
//             return (value!==location.href)?undefined:'The image is missing';
//         }
//     };
// }