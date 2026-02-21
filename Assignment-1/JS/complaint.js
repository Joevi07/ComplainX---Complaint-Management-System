const form = document.getElementById('complaintForm');
const modal = document.getElementById('successModal');

function validateName()
{
    const name = document.getElementById('name');
    const error = document.getElementById('nameError');
    if(name.value.trim().length < 2)
    {
        error.classList.add('show')
        name.style.borderColor = '#f56565'
        return false;
    }
    error.classList.remove('show')
    name.style.border = '#e2e8f0'
    return true
}

function validateEmail()
{
    const email = document.getElementById('email')
    const error = document.getElementById('emailError')
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if(!emailRegex.test(email.value))
    {
        error.classList.add('show')
        email.style.borderColor = '#f56565'
        return false
    }
    error.classList.remove('show')
    email.style.borderColor = '#e2e8f0'
    return true
}

function validateCategory()
{
    const category = document.getElementById('category')
    const error = document.getElementById('categoryError')
    if(category.value === '')
    {
        error.classList.add('show')
        category.style.borderColor = '#f56565'
        return false;
    }
    error.classList.remove('show')
    category.style.borderColor = '#e2e8f0'
    return true
}
function validateDescription()
{
    const description = document.getElementById('description')
    const error = document.getElementById('descriptionError')
    if(description.value.trim().length < 20)
    {
        error.classList.add('show')
        description.style.borderColor = '#f56565'
        return false
    }
    error.classList.remove('show');
    description.style.borderColor = '#e2e8f0';
    return true;
}

document.getElementById('name').addEventListener('blur',validateName)
document.getElementById('email').addEventListener('blur',validateEmail)
document.getElementById('category').addEventListener('change',validateCategory)
document.getElementById('description').addEventListener('blur',validateDescription)

form.addEventListener('submit', function(e){
    const isNameValid = validateName();
    const isEmailValid = validateEmail();
    const isCategoryValid = validateCategory();
    const isDescriptionValid = validateDescription();

    if(!isNameValid || !isEmailValid || !isCategoryValid || !isDescriptionValid){
        window.alert("Error in validation part");
        e.preventDefault(); 
    }
});
