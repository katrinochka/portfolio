//import {ButtonComponent} from "../../components/button/index.js";
import {ProductCardComponent} from "../../components/product_card/index.js";
import {ProductPage} from "../product/index.js";

export class MainPage {
    constructor(parent) {
        this.parent = parent;
    }

    clickCard(e) {
        //const cardId = e.target.dataset.id
    
        //const productPage = new ProductPage(this.parent, {  id: e.target.dataset.id, 
        //                                                    scr: e.target.dataset.scr, 
        //                                                    title: e.target.dataset.id, 
        //                                                    text: e.target.dataset.text});
        //productPage.render();
        const cardId = e.target.dataset.id
        
        //const productCard = new ProductCardComponent(this.pageRoot)
        //productCard.render(item, this.clickCard.bind(this))
        const productPage = new ProductPage(this.parent, cardId)
        productPage.render()
    }
    
    getData() {
        return [
            {
                id: 1,
                src: "vasya_1.png",
                title: "Василиса зимняя",
                text: "Такой милой кошки вы еще не видели!"
            },
            {
                id: 2,
                src: "tomas_2.png",
                title: "Томас",
                text: "Такого трусливого кота вы еще не видели!"
            },
            {
                id: 3,
                src: "vasya_3.png",
                title: "Василиса летняя",
                text: "Такой плюшевой кошки вы еще не видели!"
            },
        ]
    }
    
    get pageRoot() {
        return document.getElementById('main-page')
    }
        
    getHTML() {
        return (
            `
                <div id="main-page" class="d-flex flex-wrap"><div/>
            `
        )
    }
       

    render() {
        this.parent.innerHTML = ''
        const html = this.getHTML()
        this.parent.insertAdjacentHTML('beforeend', html)
        
        const data = this.getData()
        data.forEach((item) => {
            const productCard = new ProductCardComponent(this.pageRoot)
            productCard.render(item, this.clickCard.bind(this))
        })
    }
}