/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var rot = 0;
function rotateImg(img) {
    rot += 1;
    //alert(img);
    if (rot == 1) {
        var img = document.getElementById(img);
        img.setAttribute("class", "rotated-image90");
    }

    if (rot == 2) {
        var img = document.getElementById(img);
        img.setAttribute("class", "rotated-image180");
    }

    if (rot == 3) {
        var img = document.getElementById(img);
        img.setAttribute("class", "rotated-image270");
    }

    if (rot == 4) {
        var img = document.getElementById(img);
        img.setAttribute("class", "rotated-image360");
        rot = 0;
    }


}