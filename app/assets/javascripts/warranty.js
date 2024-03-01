$(document).ready(function() {
  const $warrantyStartCheckbox = $('#warranty_starts_from_purchase_date');
  const $startDateFields = $('.start_date_fields');
  const $warrantyStartPeriod = $('.warranty_start_period');
  const $warrantyPlan = $('#warranty_plan');
  const $nonComboWarrantyInputs = $('.non_combo_warranty_inputs');
  const $comboWarrantyInputs = $('.combo_warranty_inputs');
  const $countrySelect = $('#warranty_country_id');
  const $accidentalWarrantySelect = $('#warranty_accidental_warranty_id');
  const $extendedWarrantySelect = $('#warranty_extended_warranty_id');

  function fetchComboWarranties() {
    const countryId = $countrySelect.val();

    $.ajax({
      url: '/admin/warranties/fetch_combo_warranties',
      type: 'GET',
      dataType: 'json',
      data: { country_id: countryId },
      success: function(response) {
        createDropdown($accidentalWarrantySelect, response['accidental']);
        createDropdown($extendedWarrantySelect, response['extended']);
      },
      error: function() {
        console.log('Error occurred while fetching Warranties.');
      },
    });
  }

  function createDropdown(dropdown, data) {
    dropdown.empty().append($('<option>', { value: '', text: data.length === 0 ? 'No warranty present' : 'Select Warranty' }));

    for (const value of data) {
      dropdown.append($('<option>', { value: value[1], text: value[0] }));
    }
  }

  function toggleWarrantyFields() {
    const isCombo = $warrantyPlan.val() === 'combo';
    const countryId = $countrySelect.val();

    $nonComboWarrantyInputs.toggle(!isCombo);
    $nonComboWarrantyInputs.prop('disabled', isCombo);
    $comboWarrantyInputs.toggle(isCombo);
    $comboWarrantyInputs.prop('disabled', !isCombo);

    if (isCombo && !$('body').hasClass('edit') && countryId) {
      fetchComboWarranties();
    }

    if (!countryId) {
      clearDropdowns([$accidentalWarrantySelect, $extendedWarrantySelect]);
    }
  }

  function clearDropdowns(dropdowns) {
    dropdowns.forEach(dropdown => dropdown.empty().append($('<option>', { value: '', text: 'Select Warranty' })));
  }

  const handleWarrantyStartChange = () => {
    const isChecked = $warrantyStartCheckbox.is(':checked');
    $startDateFields.toggle(!isChecked);
    $warrantyStartPeriod.prop('disabled', isChecked);
  };

  handleWarrantyStartChange(); // Initial setup
  toggleWarrantyFields(); // Initial setup

  $warrantyStartCheckbox.on('change', handleWarrantyStartChange);
  $warrantyPlan.add($countrySelect).on('change', toggleWarrantyFields);
});
