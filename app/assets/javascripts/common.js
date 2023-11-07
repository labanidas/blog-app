//= require jquery
//= require jquery_ujs

// *********************** profile options for user ****************************************
$(".profile").click(() => {
  $(".user-options").toggleClass("hide");
});

// *****************************************************************************************
// ***********************************search bar logic**************************************
// *****************************************************************************************

$(".search-button").click(() => {
  // Retrieve the search values || if not exixts then give a default value
  var searchKeyword = $(".search-keyword").val();
  var fromDate = $(".from-date").val() || "1899-11-31";
  var toDate = $(".to-date").val() || new Date().toISOString().slice(0, 10);

  // Perform the search
  searchTable(searchKeyword, fromDate, toDate);
});

function searchTable(keyword, fromDate, toDate) {
  $("tbody tr").each(function () {
    var row = $(this);
    var keywordMatch = row.text().toLowerCase().includes(keyword.toLowerCase());
    var dateMatch = isDateInRange(
      row.find(".date-column").text(),
      fromDate,
      toDate
    );
    row.toggle(keywordMatch && dateMatch);
  });
}

function isDateInRange(dateString, fromDate, toDate) {
  var date = new Date(dateString);
  var fromDateObj = new Date(fromDate);
  var toDateObj = new Date(toDate);

  return date >= fromDateObj && date <= toDateObj;
}

// **************change background color of selected row ********************************

$("table tr").click(function () {
  $("tr").removeClass("table-row-selected");
  $(this).addClass("table-row-selected");
});

// *****************************************************************************************
// **************************   sort table  *****************************************************
// *****************************************************************************************
// reference --> https://stackoverflow.com/questions/14267781/sorting-html-table-with-javascript

var getCellValue = (tr, idx) => $(tr).children().eq(idx).text();

var comparer = (idx, asc) => (a, b) => {
  const v1 = getCellValue(asc ? a : b, idx);
  const v2 = getCellValue(asc ? b : a, idx);

  return isNaN(v1) || isNaN(v2) ? v1.toString().localeCompare(v2) : v1 - v2;
};
// sort table
$("#sortTable th").on("click", function () {
  const table = $(this).closest("table");
  const isAscending = $(this).hasClass("th-sort-asc");

  table.find("th").removeClass("th-sort-asc th-sort-desc");
  // If already sorted in ascending order, toggle to descending
  $(this).addClass(isAscending ? "th-sort-desc" : "th-sort-asc");

  $.makeArray(table.find("tbody tr"))
    .sort(comparer(Array.from(this.parentNode.children).indexOf(this), !isAscending))
    .forEach((tr) => table.find("tbody").append(tr));
});


// *****************************************************************************************
// **************************download data xlsv*********************************************
// *****************************************************************************************

function downloadAsXLSX(data, fileName, data_to_exclude) {
  // Exclude data entries with key "image"
  var filteredData = data.map(function (obj) {
    // Create a new object without the "image" key-value pair
    var filteredObj = {};
    for (var key in obj) {
      if (!data_to_exclude.includes(key)) {
        filteredObj[key] = obj[key];
      }
    }
    return filteredObj;
  });

  // Convert the filtered data to a worksheet
  var worksheet = XLSX.utils.json_to_sheet(filteredData);

  // Create a workbook and add the worksheet
  var workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet 1");

  // Convert the workbook to an XLSX file
  var xlsxFile = XLSX.write(workbook, { bookType: "xlsx", type: "array" });

  // Create a Blob from the file data
  var blob = new Blob([xlsxFile], {
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  });

  // Create a temporary link and trigger the download
  var url = window.URL.createObjectURL(blob);
  var link = document.createElement("a");
  link.href = url;
  link.download = fileName;
  link.click();

  // Clean up resources
  window.URL.revokeObjectURL(url);
}
