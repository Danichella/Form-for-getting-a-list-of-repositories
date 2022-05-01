const onToasterCloseHandler = () => {
    Array.from(document.getElementsByClassName("toaster-container")).forEach(toaster => {
        toaster.style.display = "none";
    });
};