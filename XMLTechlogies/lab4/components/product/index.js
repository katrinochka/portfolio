export class ProductComponent {
    constructor(parent) {
        this.parent = parent
    }

    getHTML(data) {
        console.log(data)
        return (
            `
                <div class="card mb-3" style="width: 540px;">
                    <div class="row g-0">
                        <div class="col-md-4">
                            <img src="${data.photo_400_orig}" class="img-fluid" alt="картинка">
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h3 class="card-title">${data.first_name} ${data.last_name}</h3>
                                <h6>${data.first_name_gen} ${data.last_name_gen}</h6>
                            </div>
                        </div>
                    </div>
                </div>
            `
        )
    }

    render(data) {
        const html = this.getHTML(data)
        this.parent.insertAdjacentHTML('beforebegin', html)
    }
}
