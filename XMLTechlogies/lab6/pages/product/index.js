import {ProductComponent} from "../../components/product/index.js";
import {BackButtonComponent} from "../../components/back_button/index.js";
import {MainPage} from "../main/index.js";

export class ProductPage {
    constructor(parent, data) {
        this.parent = parent
        this.data = data
    }

    getData() {
        let tempscr = "vasya_3.png"
        if (this.data.id == 1) {
            tempscr = "vasya_1.png"
        }
        else if (this.data.id == 2) {
            tempscr = "tomas_20.png"
        }

        return {
            id: this.data.id,
            scr: tempscr,
            title: this.data.title,
            text: this.data.text
        }
    }

    get pageRoot() {
        return document.getElementById('product-page')
    }

    getHTML() {
        return (
            `
                <div id="product-page"></div>
            `
        )
    }

    clickBack() {
        const mainPage = new MainPage(this.parent)
        mainPage.render(0)
    }
    
    render() {
        this.parent.innerHTML = ''
        const html = this.getHTML()
        this.parent.insertAdjacentHTML('beforeend', html)
    
        const backButton = new BackButtonComponent(this.pageRoot)
        backButton.render(this.clickBack.bind(this))

        const data = this.getData()
        const stock = new ProductComponent(this.pageRoot)
        stock.render(data)
    }
    
}