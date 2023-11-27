const rsSuccess = (text) => {
    Swal.fire({
        html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/lupuorrc.json" trigger="loop" colors="primary:#0ab39c,secondary:#405189" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Well done !</h4><p class="text-muted mx-4 mb-0">' + text + ' successfully</p></div></div>',
        showCancelButton: true,
        showConfirmButton: false,
        customClass: {
            cancelButton: 'btn btn-primary w-xs mb-1'
        },
        cancelButtonText: "Back",
        buttonsStyling: false,
        showCloseButton: true
    })
}
const rsSuccessLoad = (text) => {
    Swal.fire({
        html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/lupuorrc.json" trigger="loop" colors="primary:#0ab39c,secondary:#405189" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Well done !</h4><p class="text-muted mx-4 mb-0">' + text + ' successfully</p></div></div>',
        showCancelButton: true,
        showConfirmButton: false,
        customClass: {
            cancelButton: 'btn btn-primary w-xs mb-1'
        },
        cancelButtonText: "Back",
        buttonsStyling: false,
        showCloseButton: true
    }).then((result) => {
        if (result.dismiss === Swal.DismissReason.cancel || result.dismiss === Swal.DismissReason.close) {
            window.location.reload();
        }
    })
}
const rsUnSuccess = () => {
    Swal.fire({
        html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/tdrtiskw.json" trigger="loop" colors="primary:#f06548,secondary:#f7b84b" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Oops...! Something went Wrong !</h4><p class="text-muted mx-4 mb-0">Try Again</p></div></div>',
        showCancelButton: true,
        showConfirmButton: false,
        customClass: {
            cancelButton: 'btn btn-primary w-xs mb-1'
        },
        cancelButtonText: "Dismiss",
        buttonsStyling: false,
        showCloseButton: true
    })
}
const validateFail = (error) => {
    Swal.fire({
        html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/tdrtiskw.json" trigger="loop" colors="primary:#f06548,secondary:#f7b84b" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>' + error + '</h4><p class="text-muted mx-4 mb-0">Try Again</p></div></div>',
        showCancelButton: true,
        showConfirmButton: false,
        customClass: {
            cancelButton: 'btn btn-primary w-xs mb-1'
        },
        cancelButtonText: "Dismiss",
        buttonsStyling: false,
        showCloseButton: true
    })
}