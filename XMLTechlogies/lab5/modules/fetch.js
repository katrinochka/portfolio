import { loading_page } from "../main.js";

/*class Fetch {
    get = async(url) =>{
    loading_page.set_visibility(true)
    try {
        let resp = await fetch(url);
        let result = await resp.json();
        return result.response;
    } catch (error) {
        console.log("Ошибочка вышла...")
        return 0;
    } finally{
        loading_page.set_visibility(false)
    }
  }
}*/

class Fetch {
    get(url) {
      loading_page.set_visibility(true);
      return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        xhr.onload = () => {
          if (xhr.status >= 200 && xhr.status < 300) {
            const result = JSON.parse(xhr.response);
            loading_page.set_visibility(false);
            resolve(result.response);
          } else {
            console.log("Ошибочка вышла...");
            loading_page.set_visibility(false);
            reject(0);
          }
        };
        xhr.onerror = () => {
          console.log("Ошибка запроса");
          loading_page.set_visibility(false);
          reject(0);
        };
        xhr.send();
      });
    }
  }


/*class Fetch {
    post(url, callback) {
      loading_page.set_visibility(true);
      fetch(url)
        .then(resp => resp.json())
        .then(result => {
          loading_page.set_visibility(false);
          callback(result.response); // Вызываем callback с результатом
        })
        .catch(error => {
          console.log("Ошибочка вышла...");
          loading_page.set_visibility(false);
          callback(0); // Вызываем callback с ошибкой
        });
    }
  }*/

/*class Fetch {
    post(url, callback) {
        let xhr = new XMLHttpRequest()
        xhr.open('POST', (url))
        xhr.send()
        xhr.onreadystatechange = () => {
            if (xhr.readyState === 4) {
                const data = JSON.parse(xhr.response)
                callback(data)
            }
        }
    }    
}*/

export const fetch_obj = new Fetch();