class Urls {
    constructor() {
        this.url = 'http://localhost:8000/cats'
    }

    getCats(params) { //get
        var query_string='?'
        for (const [key,value] of Object.entries(params)){
            query_string+=`${key}=${value}&`
        }
        query_string = query_string.substring(0,query_string.length-1)//trim off the last char
        if (query_string.length===1){query_string=''}//empty if no params passed
        return `${this.url}/${query_string}`
    }

    getCatById(catID) { //get
        return `${this.url}/${catID}`
    }

    addCat(){ //post
        return `${this.url}/`
    }
    
    deleteCat(catID){ //delete
        return `${this.url}/${catID}`
    }
}

export const urls = new Urls()