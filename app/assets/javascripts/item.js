$(document).ready(function() {
  if ($('body').hasClass('admin_items')) {
    const $countrySelect = $('#item_country_id');
    const $categorySelect = $('#item_category_id');
    const $itemWarrantiesInput = $('#item_warranties_input');
    const $warrantiesLabel = $itemWarrantiesInput.find('.choices .label').children('label');
    const $warrantiesChoicesGroup = $itemWarrantiesInput.find('.choices-group');
    const $liInput = $itemWarrantiesInput.find('.choices li')
    $countrySelect.add($categorySelect).on('change', fetchWarranties);

    function fetchWarranties() {
      const countryId = $countrySelect.val();
      const categoryName = $categorySelect.find(':selected').text();

      $.ajax({
        url: '/admin/items/fetch_item_warranties',
        type: 'GET',
        dataType: 'json',
        data: { country_id: countryId, category_name: categoryName },
        success: function(response) {
          $itemWarrantiesInput.toggle(response.length > 0);
          $warrantiesLabel.text(response.length > 0 ? 'Warranties' : '');

          updateWarrantyCheckboxes(response);
        },
        error: function() {
          console.log('Error occurred while fetching Warranties.');
        },
      });
    }

    function updateWarrantyCheckboxes(warranties_collection) {
      $warrantiesChoicesGroup.empty();
      $liInput.remove();
      warranties_collection.forEach(function(warranty) {
        const li = $('<li>').addClass('choice');
        const input = $('<input>').attr({
          id: `item_warranty_ids_${warranty[1]}`,
          name: 'item[warranty_ids][]',
          type: 'checkbox',
          value: warranty[1],
        });
        const label = $('<label>').attr('for', `item_warranty_ids_${warranty[1]}`).text(warranty[0]);

        label.prepend(input);
        li.append(label);
        $warrantiesChoicesGroup.append(li);
      });
    }
  }
});
