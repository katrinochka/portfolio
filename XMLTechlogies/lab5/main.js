import {MainPage} from "./pages/main/index.js";
import { LoadingPage } from "./pages/loading/index.js";

const root = document.getElementById('root');

const mainPage = new MainPage(root, 0);
export const loading_page = new LoadingPage();
loading_page.render();
mainPage.render();