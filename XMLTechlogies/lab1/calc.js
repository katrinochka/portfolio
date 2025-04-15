window.onload = function(){ 

    let a = ''
    let b = ''
    let expressionResult = ''
    let selectedOperation = null
    
    // окно вывода результата
    outputElement = document.getElementById("result")
    
    // список объектов кнопок циферблата (id которых начинается с btn_digit_)
    digitButtons = document.querySelectorAll('[id ^= "btn_digit_"]')
    
    function onDigitButtonClicked(digit) {
        if (!selectedOperation) {
            if ((digit != '.') || (digit == '.' && !a.includes(digit))) { 
                a += digit
            }
            outputElement.innerHTML = a
        } else {
            if ((digit != '.') || (digit == '.' && !b.includes(digit))) { 
                b += digit
                outputElement.innerHTML = b        
            }
        }
    }
    
    // устанавка колбек-функций на кнопки циферблата по событию нажатия
    digitButtons.forEach(button => {
        button.onclick = function() {
            const digitValue = button.innerHTML
            onDigitButtonClicked(digitValue)
        }
    });

    document.getElementById("btn_change_background").onclick = function(){
        /*if(document.body.style.backgroundColor != "white"){
            document.body.style.backgroundColor = "white"
            document.body.style.backgroundImage = "URL('hypsofil.png')"
        }
        else{
            document.body.style.backgroundColor = "purple"
            document.body.style.backgroundImage = ""
        }*/
        if (document.body.style.backgroundImage == 'none') {
            document.body.style.backgroundImage = "url('hypsofil.png')";
        } else {
            document.body.style.backgroundImage = 'none';
        }
    }
    
    // установка колбек-функций для кнопок операций
    document.getElementById("btn_op_mult").onclick = function() { 
        if (a === '') return
        selectedOperation = 'x'
    }
    document.getElementById("btn_op_plus").onclick = function() { 
        if (a === '') return
        selectedOperation = '+'
    }
    document.getElementById("btn_op_minus").onclick = function() { 
        if (a === '') return
        selectedOperation = '-'
    }

    document.getElementById("btn_op_minus").onclick = function() {  
        if (a === '') return 
        if (!selectedOperation) { 
            selectedOperation = '-' 
        } else {
            if (b !== '') { 
                a = (+a) - (+b)
                b = ''
                outputElement.innerHTML = a   
                selectedOperation = '-'  
            }
        }
    }


    document.getElementById("btn_op_div").onclick = function() { 
        if (a === '') return
        selectedOperation = '/'
    }
    document.getElementById("btn_op_BS").onclick = function() { 
        if (a.length>0 || b.length>0){
            if (!selectedOperation){
                a = a.slice(0, -1)
                if (a.length === 0){
                    outputElement.innerHTML = 0
                }
                else{
                    outputElement.innerHTML = a
                }
            }
            else{
                b = b.slice(0, -1)
                if (b.length === 0){
                    outputElement.innerHTML = 0
                }
                else{
                    outputElement.innerHTML = b
                }
            }
        }    
    }
    
    // кнопка очищения
    document.getElementById("btn_op_clear").onclick = function() { 
        a = ''
        b = ''
        selectedOperation = ''
        expressionResult = ''
        outputElement.innerHTML = 0
    }
    
    // кнопка расчёта результата
    document.getElementById("btn_op_equal").onclick = function() { 
        if (a === '' || b === '' || !selectedOperation)
            return
            
        switch(selectedOperation) { 
            case 'x':
                expressionResult = (+a) * (+b)
                break;
            case '+':
                expressionResult = (+a) + (+b)
                break;
            case '-':
                expressionResult = (+a) - (+b)
                break;
            case '/':
                expressionResult = (+a) / (+b)
                break;
        }
        
        a = expressionResult.toString()
        b = ''
        selectedOperation = null
    
        outputElement.innerHTML = a
    }
};