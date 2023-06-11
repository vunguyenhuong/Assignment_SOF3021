imgInp.onchange = evt => {
    const [file] = imgInp.files
    if (file) {
        blah.src = URL.createObjectURL(file)
    }
}
imgUpdateInp.onchange = evt => {
    const [file] = imgUpdateInp.files
    if (file) {
        productImage.src = URL.createObjectURL(file)
    }
}

function showConfirm(text,url) {
    swal({
        title: "Are you sure?",
        text: text,
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
        .then((willDelete) => {
            if (willDelete) {
                window.location.href = url;
            }
        });
}

function showImage(image){
    $('#imageDetail').attr('src', '/resources/images/products/'+image);
    $('#modalInfo').modal('show');
}

function showConfirmSubmit(text,id){
    swal({
        title: "Are you sure?",
        text: text,
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
        .then((will) => {
            if (will) {
                document.getElementById(id).submit();
            }
        });
}
function checkFormSubmit(e){
    const ma = document.getElementById('ma').value;
    const ten = document.getElementById('ten').value;
    const soLuong = document.getElementById('soLuong').value;
    const donGia = document.getElementById('donGia').value;
    const message = document.getElementsByClassName('error');
    e.preventDefault();
    ma == '' ? message[0].innerHTML = 'Không được để trống!' : message[0].innerHTML = ''
    ten == '' ? message[1].innerHTML = 'Không được để trống!' : message[1].innerHTML = ''
    soLuong == '' ? message[2].innerHTML = 'Không được để trống!' : message[2].innerHTML = ''
    donGia == '' ? message[3].innerHTML = 'Không được để trống!' : message[3].innerHTML = ''
    if(ma != '' & ten != '' & soLuong != '' & donGia != ''){
        document.getElementById("formAddProduct").submit();
    }
}