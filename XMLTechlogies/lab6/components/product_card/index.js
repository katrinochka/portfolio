export class ProductCardComponent {
    constructor(parent) {
        this.parent = parent;
    }

    getHTML(data, CatID) {
        return (
            `
                <div class="card" style="width: 300px;">
                    <img class="card-img-top" src="${data.src}" alt="картинка">
                    <div class="card-body">
                        <h5 class="card-title">${data.title}</h5>
                        <p class="card-text">${data.text}</p>
                        <button class="btn btn-primary" id="click-card-${data.id}" data-id="${data.id}" data-scr=${data.scr} data-title="${data.title}" data-text="${data.text}">Нажми на меня</button>
                    </div>
                </div>
            `
        )
    }
    
    addListeners(data, listener) {
        document
            .getElementById(`click-card-${data.id}`)
            .addEventListener("click", listener)
    }
    
    render(data, CatID, listener) {
        let html = this.getHTML(data)
        if ((CatID!=0)&&(CatID==data.id)){
            console.log(CatID)
            html = html.replace('<h5 class="card-title">', '<h5 class="card-title"><span class="badge bg-secondary">Новый</span> ');
        }
        this.parent.insertAdjacentHTML('beforeend', html)
        this.addListeners(data, listener)
    }
}