const hamburger = document.querySelector(".hamburger");
const menu = document.querySelector(".nav-links");
console.log(hamburger)
console.log(menu)

hamburger.addEventListener("click", () => {
    hamburger.classList.toggle("active")



    menu.classList.toggle("active")
});

document.querySelectorAll(".nav-item").forEach(n => n.addEventListener("click", () => {
    hamburger.classList.remove("active");
    menu.classList.remove("active")
}))