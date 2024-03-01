$(document).ready(function () {
  if ($("body").hasClass("admin_categories")) {
    $(document).on("change", ".warranty_dropdown", function(e) {
      const targetWarranty = $(this);
      const selectedValue = targetWarranty.val();

      // Filter out empty values and check for duplicates
      const duplicateExists = $(".warranty_dropdown")
        .filter((index, element) => $(element).val() && $(element).val() === selectedValue && $(element).attr("id") !== targetWarranty.attr("id"))
        .length > 0;

      if (duplicateExists) {
        targetWarranty.siblings(".error-message").remove();
        targetWarranty.after('<br><span class="error-message"> This warranty is already selected</span>');
      } else {
        targetWarranty.siblings(".error-message").remove();
      }
    });
  }
});
