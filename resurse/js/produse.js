window.onload=function(){
    //salvare produse originale pentru resetare
    let produseList = document.getElementsByClassName("produs")
    let produseOriginale = Array.from(produseList)
    let containerProduse = produseList.length > 0 ? produseList[0].parentNode : null

    //cod range capacitate
    document.getElementById("inp-capacitate").oninput=function(){
        let val=this.value.trim();
        document.getElementById("afis-range").innerHTML=`(${val})`;
    }

    document.getElementById("filtreaza").onclick=function(){

        //cod input text
        let inpNume=document.getElementById("inp-nume").value.trim().toLowerCase();
        let inpNumeElement = document.getElementById("inp-nume");
        let regexNume = /^[a-z]*$/;
        if (regexNume.test(inpNume) == false) {
            inpNumeElement.classList.add("input-eroare");
            setTimeout(function() {
                inpNumeElement.classList.remove("input-eroare");
            }, 400);
            let eroareDiv = document.createElement("div");
            eroareDiv.innerHTML = "Numele introdus nu este valid. Folosiți doar litere.";
            inpNumeElement.parentNode.insertBefore(eroareDiv, inpNumeElement);
            inpNumeElement.parentNode.style.position = "relative";
            eroareDiv.style.color = "red";
            eroareDiv.style.zIndex = "9999";
            eroareDiv.style.position = "absolute";
            eroareDiv.style.backgroundColor = "white";
            eroareDiv.style.padding = "5px 10px";
            eroareDiv.style.left = inpNumeElement.offsetLeft + "px";
            eroareDiv.style.top = (inpNumeElement.offsetTop - eroareDiv.offsetHeight - 5) + "px";
            setTimeout(function() {
                eroareDiv.remove();
            }, 2000);
            return;
        }

        let produse=document.getElementsByClassName("produs");
        let CapacitateMin=parseInt(document.getElementById("inp-capacitate").value.trim());

        //cod datalist
        let marca=document.getElementById("inp-datalist").value.trim().toLowerCase();
        if(marca!="")
        {
            let marcaElement=document.getElementById("inp-datalist");
            let optiuni = marcaElement.list.options;
            let marcaValida=false;
            for(let opt of optiuni){
                if(opt.value.trim().toLowerCase()==marca){
                    marcaValida=true;
                    break;
                }
            }
            if(marcaValida==false){
                marcaElement.classList.add("input-eroare");
                setTimeout(function() {
                    marcaElement.classList.remove("input-eroare");
                }, 400);
                let eroareDiv = document.createElement("div");
                eroareDiv.innerHTML = "Marca introdusă nu este validă. Vă rugăm să selectați o marcă din listă.";
                marcaElement.parentNode.insertBefore(eroareDiv, marcaElement);
                marcaElement.parentNode.style.position = "relative";
                eroareDiv.style.color = "red";
                eroareDiv.style.zIndex = "9999";
                eroareDiv.style.position = "absolute";
                eroareDiv.style.backgroundColor = "white";
                eroareDiv.style.padding = "5px 10px";
                eroareDiv.style.left = marcaElement.offsetLeft + "px";
                eroareDiv.style.top = (marcaElement.offsetTop - eroareDiv.offsetHeight - 5) + "px";
                setTimeout(function() {
                    eroareDiv.remove();
                }, 2000);
                return;
            }
        }

        //cod radio
        let grupRadio=document.getElementsByName("rad-utilizare");
        let radioSelected="",isToate=false;
        for(let rad of grupRadio){
            if(rad.checked){
                if(rad.value!="toate"){
                    radioSelected=rad.value
                }else{
                    isToate=true;
                }
                break;
            }
        }

        //cod checkbox
        let inStoc=document.getElementById("inp-stoc").checked

        //cod textarea
        let textareaVal = document.getElementById("inp-textarea").value.trim().toLowerCase();
        let textareaElement = document.getElementById("inp-textarea");
        let regexCaractereValide = /^[a-z+\-\s]+$/;
        if (textareaVal !== "" && (!regexCaractereValide.test(textareaVal) || /[a-z][+\-]/.test(textareaVal) ||(!textareaVal.includes('+') && !textareaVal.includes('-')) || / [^+\-]/.test(textareaVal))) {
            textareaElement.classList.add("is-invalid");
            textareaElement.oninput = function() {
                let val = this.value.trim().toLowerCase();
                let esteInvalid = val !== "" && (!regexCaractereValide.test(val) || /[a-z][+\-]/.test(val) || (!val.includes('+') && !val.includes('-')) || / [^+\-]/.test(val));
                if (!esteInvalid) {
                    this.classList.remove("is-invalid");
                }
            }
            return;
        }
        let cuvintePlus = [];
        let cuvinteMinus = [];
        if (textareaVal !== "") {
            let tokens = textareaVal.split(/\s+/);
            for (let token of tokens) {
                if (token.startsWith("+") && token.length > 1) {
                    cuvintePlus.push(token.substring(1));
                } else if (token.startsWith("-") && token.length > 1) {
                    cuvinteMinus.push(token.substring(1));
                }
            }
        }

        //cod select simplu
        let selectPermis=document.getElementById("sel-categorie-permis").value.trim().toLowerCase();

        //cod select multiplu
        let selectMultiplu = document.getElementById("sel-multiplu-pret");
        let intervaleSelectate = [];
        for (let opt of selectMultiplu.options) {
            if (opt.selected) {
                intervaleSelectate.push(opt.value);
            }
        }

        //filtrare produse
        for(let prod of produse){
            prod.style.display="none";

            //cond1 - filtru input text (nume)
            let nume=prod.getElementsByClassName("val-nume")[0].innerHTML.trim().toLowerCase();
            let cond1=nume.includes(inpNume);

            //cond2 - filtru range (capacitate minima)
            let cond2=parseInt(prod.getElementsByClassName("val-capacitate")[0].innerHTML.trim())>=CapacitateMin;

            //cond3 - filtru datalist (marca)
            let cond3=marca=="" || prod.getElementsByClassName("val-marca")[0].innerHTML.trim().toLowerCase()==marca;

            //cond4 - filtru radio (categorie utilizare)
            let cond4=isToate || radioSelected=="" || prod.getElementsByClassName("val-utilizare")[0].innerHTML.trim().toLowerCase()==radioSelected;

            //cond5 - filtru checkbox (doar in stoc)
            let stocProdText = prod.getElementsByClassName("val-stoc")[0].innerHTML.trim().toLowerCase();
            let cond5 = false;
            if (inStoc == false) {
                cond5 = true;
            } else {
                if (stocProdText == "da") {
                    cond5 = true;
                } else {
                    cond5 = false;
                }
            }

            //cond6 - filtru textarea (cuvinte + si -)
            let descriereProd = prod.getElementsByClassName("val-descriere")[0].innerHTML.trim().toLowerCase();
            let condPlus = true;
            if (cuvintePlus.length > 0) {
                condPlus = false;
                for (let cuvant of cuvintePlus) {
                    if (descriereProd.includes(cuvant)) {
                        condPlus = true;
                        break;
                    }
                }
            }
            let condMinus = true;
            for (let cuvant of cuvinteMinus) {
                if (descriereProd.includes(cuvant)) {
                    condMinus = false;
                    break;
                }
            }
            let cond6 = condPlus && condMinus;

            //cond7 - filtru select simplu (categorie permis)
            let cond7 = prod.getElementsByClassName("val-categorie-permis")[0].innerHTML.trim().toLowerCase() == selectPermis||selectPermis=="oricare";

            //cond8 - filtru select multiplu (interval pret)
            let cond8 = true;
            let pretProd = parseFloat(prod.getElementsByClassName("val-pret")[0].innerHTML.trim());
            if (intervaleSelectate.length > 0) {
                let minGlobal = Infinity;
                let maxGlobal = -Infinity;

                for (let interval of intervaleSelectate) {
                    let limite = interval.split("-");
                    let min = parseInt(limite[0]);
                    let max = parseInt(limite[1]);
                    if (min < minGlobal) minGlobal = min;
                    if (max > maxGlobal) maxGlobal = max;
                }
                cond8 = pretProd >= minGlobal && pretProd <= maxGlobal;
            }

            //afisare produs daca trece toate filtrele
            if(cond1 && cond2 && cond3 && cond4 && cond5 && cond6 && cond7&& cond8){
                prod.style.display="block";
            }
        }
    }

    //cod resetare
    document.getElementById("resetare").onclick=function(){
        let confirmare = confirm("Sigur doriti sa resetati filtrele si sa anulati sortarea?")
        if(confirmare==true){
            document.getElementById("inp-nume").value=""
            document.getElementById("inp-capacitate").value="49"
            document.getElementById("afis-range").innerHTML="(49)"
            document.getElementById("inp-datalist").value=""
            document.getElementById("rad-toate").checked=true
            document.getElementById("inp-stoc").checked=false
            document.getElementById("inp-textarea").value=""
            document.getElementById("sel-categorie-permis").value="oricare"
            let selectMultiplu = document.getElementById("sel-multiplu-pret")
            for (let opt of selectMultiplu.options) {
                opt.selected = false;
            }
            let produse=document.getElementsByClassName("produs")
            if(containerProduse){
                for(let prod of produseOriginale){
                    prod.style.display="block"
                    containerProduse.appendChild(prod)
                }
            }
        }
    }

    //cod sortare
    function sorteaza(semn){
        let produse=document.getElementsByClassName("produs")
        let vProduse= Array.from(produse)
        vProduse.sort(function(a,b){
            let pretA=parseFloat(a.getElementsByClassName("val-pret")[0].innerHTML.trim())
            let pretB=parseFloat(b.getElementsByClassName("val-pret")[0].innerHTML.trim())
            if (pretA==pretB){
                let numeA=a.getElementsByClassName("val-nume")[0].innerHTML.trim().toLowerCase()
                let numeB=b.getElementsByClassName("val-nume")[0].innerHTML.trim().toLowerCase()
                return semn*numeA.localeCompare(numeB)
            }

            return semn*(pretA-pretB)
        })
        for (let prod of vProduse){
            prod.parentElement.appendChild(prod)
        }
    }

    document.getElementById("sort-asc").onclick=function(){sorteaza(1)}
    document.getElementById("sort-desc").onclick=function(){sorteaza(-1)}

    //cod calcul pret maxim
    document.getElementById("calcul").onclick=function(){
        let produse=document.getElementsByClassName("produs")
        let maxPret=-Infinity
        for(let prod of produse){
            let pret=parseFloat(prod.getElementsByClassName("val-pret")[0].innerHTML.trim())
            if(pret>maxPret){
                maxPret=pret
            }
        }
        let rezultat=document.createElement("div")
        if(maxPret== -Infinity){
            rezultat.innerHTML="Nu exista produse vizibile pentru a calcula pretul maxim."
        }else{
            rezultat.innerHTML=`Pretul maxim dintre produsele vizibile este: ${maxPret}`
        }
        let btn = document.getElementById("calcul");
        btn.parentNode.insertBefore(rezultat, btn);
        btn.parentNode.style.position = "relative";
        rezultat.style.position = "absolute"
        rezultat.style.backgroundColor = "white"
        rezultat.style.color = "black"
        rezultat.style.padding = "5px 10px"
        rezultat.style.border = "2px solid black"
        rezultat.style.borderRadius = "5px"
        rezultat.style.fontWeight = "bold"
        rezultat.style.zIndex = "9999"
        rezultat.style.left = btn.offsetLeft + "px";
        rezultat.style.top = (btn.offsetTop - rezultat.offsetHeight - 5) + "px";
        setTimeout(function(){
            rezultat.remove()
        },2000)
    }
}
