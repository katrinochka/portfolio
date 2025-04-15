import {ProductCardComponent} from "../../components/product_card/index.js";
import {ProductPage} from "../product/index.js";
import { fetch_obj } from "../../server_modules/fetch.js";
import { urls } from "../../server_modules/urls.js";

export class MainPage {
    constructor(parent) {
        this.parent = parent;
    }

    clickCard(e) {
        const data_cur = {    id: e.target.dataset.id, 
                            scr: e.target.dataset.scr, 
                            title: e.target.dataset.title, 
                            text: e.target.dataset.text}

        const productPage = new ProductPage(this.parent, data_cur)
        productPage.render()
    }
    
    
    get pageRoot() {
        return document.getElementById('main-page')
    }
        
    getHTML() {
        return (
            `
                <button id="add-product" class="btn btn-primary mt-3">Добавить кошечку</button>
                <div id="add-product-form" style='display: none'>
                    <h3>Добавить продукт</h3>
                    <form id="product-form">
                        <div class="mb-3">
                            <label for="product-id" class="form-label">Номер</label>
                            <input type="number" class="form-control" id="product-id" required>
                        </div>
                        <div class="mb-3">
                            <label for="product-title" class="form-label">Имя</label>
                            <input type="text" class="form-control" id="product-title" required>
                        </div>
                        <div class="mb-3">
                            <label for="product-text" class="form-label">Описание</label>
                            <textarea class="form-control" id="product-text" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="product-src" class="form-label">URL картинки</label>
                            <input type="url" class="form-control" id="product-src" required>
                        </div>
                        <button type="submit" class="btn btn-success">Сохранить</button>
                        <button type="button" class="btn btn-secondary" id="cancel-add">Отмена</button>
                    </form>
                </div>
                <button id="delete-product" class="btn btn-primary mt-3">Удалить кошечку</button>
                <div id="delete-product-form" style='display: none'>
                    <h3>Удалить кошечку</h3>
                    <form id="delete-form">
                        <div class="mb-3">
                            <label for="product-id-delete" class="form-label">Номер котика</label>
                            <input type="number" class="form-control" id="product-id-delete" required>
                        </div>
                        <button type="submit" class="btn btn-success">Сохранить</button>
                        <button type="button" class="btn btn-secondary" id="cancel-delete">Отмена</button>
                    </form>
                </div>
                <div id="main-page" class="d-flex flex-wrap"><div/>
            `
        )
    }

    showAddProductForm() {
        document.getElementById('add-product-form').style.display = 'block';
    }

    hideAddProductForm() {
        document.getElementById('add-product-form').style.display = 'none';
    }

    showDeleteProductForm() {
        document.getElementById('delete-product-form').style.display = 'block';
    }

    hideDeleteProductForm() {
        document.getElementById('delete-product-form').style.display = 'none';
    }

    addEventListeners() {
        document.getElementById('add-product').addEventListener('click', this.showAddProductForm.bind(this));
        document.getElementById('cancel-add').addEventListener('click', this.hideAddProductForm.bind(this));
        document.getElementById('product-form').addEventListener('submit', this.submitAddProductForm.bind(this));
        document.getElementById('delete-product').addEventListener('click', this.showDeleteProductForm.bind(this));
        document.getElementById('cancel-delete').addEventListener('click', this.hideDeleteProductForm.bind(this));
        document.getElementById('delete-form').addEventListener('submit', this.submitDeleteProductForm.bind(this));
    }

    async submitDeleteProductForm(e) {
        e.preventDefault();
        const catID = document.getElementById('product-id-delete').value;

        const result = fetch_obj.delete(urls.deleteCat(catID));
        if (result) {
            alert('Кошечка успешно удалена');
            this.hideDeleteProductForm();
            this.render(0);
        } else {
            alert('Ошибка при удалении кошечки');
        }
    }

    async submitAddProductForm(e) {
        e.preventDefault();
        const id = document.getElementById('product-id').value;
        const title = document.getElementById('product-title').value;
        const text = document.getElementById('product-text').value;
        const src = document.getElementById('product-src').value;

        const newCat = { id, title, text, src };
        const result = fetch_obj.post(urls.addCat(), newCat);
        if (result) {
            alert('Кошечка успешно добавлен');
            this.hideAddProductForm();
            this.render(id);
        } else {
            alert('Ошибка при добавлении кошечки');
        }
    }

    render(CatID) {
        this.parent.innerHTML = ''
        const html = this.getHTML()
        this.parent.insertAdjacentHTML('beforeend', html)

        var params = {alphabet: true, ascending: true}
        fetch_obj.get(urls.getCats(params)).then((result) => {
            result.forEach((item) => {
                const ProductCard = new ProductCardComponent(this.pageRoot)
                ProductCard.render(item, CatID, this.clickCard.bind(this))
            })
        })

        this.addEventListeners();
    }
}