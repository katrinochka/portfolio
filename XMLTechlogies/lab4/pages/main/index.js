
import { ProductCardComponent } from "../../components/product_card/index.js";
import { ProductPage } from "../product/index.js";
import { ajax } from "../../modules/ajax.js";
import { urls } from "../../modules/urls.js";
import { ChatChoosingComponent } from "../../components/chat_choosing/index.js";

export class MainPage {
    constructor(parent, chat_chosen) {
        this.parent = parent;
        this.chat_chosen = chat_chosen
    }

    get pageRoot() {
        return document.getElementById('main-page');
    }

    getHTML() {
        return (
            `
                <div id="main-page" class="d-flex flex-wrap"><div/>
            `
        )
    }

    getData() {
        if (this.chat_chosen!=0){
            ajax.post(urls.getConversationMembers(this.chat_chosen), data => {
                this.renderData(data.response.profiles)
            })
        }
    }

    clickCard(e) {
        const cardId = e.target.dataset.id;
        const productPage = new ProductPage(this.parent, cardId, this.chat_chosen);
        productPage.render();
    }

    renderData(items) {
        items.forEach((item) => {
            const productCard = new ProductCardComponent(this.pageRoot)
            productCard.render(item, this.clickCard.bind(this))
        })
    }

    chatChosen() {
        this.chat_chosen = document.getElementById("chat_selector").value
        document.getElementById("main-page").innerHTML = ''
        this.getData()
    }

    render() {
        this.parent.innerHTML = ''
        const html = this.getHTML()
        this.parent.insertAdjacentHTML('beforeend', html)
    
        const chooseComp = new ChatChoosingComponent(this.pageRoot,this)
        chooseComp.render(this.chatChosen.bind(this))
    }
}
