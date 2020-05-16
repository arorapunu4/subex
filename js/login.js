$(document).ready(function() {
  var totalPossibleAttempts = 3;
  var password = '1234567';
  var validMail = false;
  var validPassword = false;

  // reset defaults
  var form = document.forms[0];
  for (var i = 0; i < form.length; i++) {
    if (form[i].tagName === 'INPUT') {
      form[i].value = '';
    }
  }

  function validateEmail(email) {
    var emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return emailRegex.test(email);
  }

  function applyError(e, elem) {
    e.stopPropagation();
    $(elem).hasClass('valid') ? elem.classList.remove('valid') : null;
    elem.classList.add('invalid');
  }

  function removeError(e, elem) {
    e.stopPropagation();
    $(elem).hasClass('invalid') ? elem.classList.remove('invalid') : null;
    elem.classList.add('valid');
  }

  function showErrorMessage(elem) {
    var errorEle = elem.parentNode.lastElementChild;
    errorEle.classList.remove('in-visible');
    errorEle.classList.add('visible');
  }

  function hideErrorMessage(elem) {
    var errorEle = elem.parentNode.lastElementChild;
    errorEle.classList.remove('visible');
    errorEle.classList.add('in-visible');
  }

  function checkValidity() {
    if (validMail && validPassword) {
      document
        .querySelector('button[type="submit"]')
        .classList.remove('disabled');
    } else {
      document.querySelector('button[type="submit"]').classList.add('disabled');
    }
  }

  $('#email-input').focusout(function(e) {
    var email = this.value;
    var checkElem = document.querySelector('.check');
    if (validateEmail(email)) {
      validMail = true;
      removeError(e, this);
      hideErrorMessage(this);
      checkElem.classList.remove('hide');
      checkElem.classList.add('show');
    } else {
      validMail = false;
      applyError(e, this);
      showErrorMessage(this);
      checkElem.classList.remove('show');
      checkElem.classList.add('hide');
    }
    checkValidity();
  });

  $('#password-input').focusout(function(e) {
    var password = this.value;
    if (password.length === 0 || password.length <= 5) {
      validPassword = false;
      applyError(e, this);
      showErrorMessage(this);
    } else {
      validPassword = true;
      removeError(e, this);
      hideErrorMessage(this);
    }
    checkValidity();
  });

  $('#password-input ~ img').click(function() {
    var passwordElem = this.parentNode.firstElementChild;
    if ($(passwordElem).attr('type') === 'password') {
      $(passwordElem).attr('type', 'text');
    } else {
      $(passwordElem).attr('type', 'password');
    }
  });

  $('.signin').click(function(e) {
    e.preventDefault();
    var passwordInput = document.querySelector('#password-input');
    if (totalPossibleAttempts <= 1) {
      window.location.href = '/index.html';
      return;
    }
    if (passwordInput.value !== password) {
      totalPossibleAttempts--;
      document.querySelector('.error-container').classList.add('visible');
      document.querySelector('.count').innerHTML = totalPossibleAttempts;
    } else {
      document.querySelector('.error-container').classList.remove('visible');
    }
  });
});
