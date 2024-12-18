import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? customerNameValue;
  String? placeValueChanges;
  String? paymentTypeValue;
  final List<String> customerNames = [
    'Nazriya Nazim',
    'Aishwarya Lekshmi',
    'Rajisha Vijayan',
    'Keerthy Suresh',
    'Madonna Sebastian'
  ];

  List<String> selectedCustomerNames = [];
  final List<String> place = ['Kannur', 'Wayyand', 'Kollam', 'Kottayam'];
  final List<String> paymentType = ['Google Pay', 'Paytm', 'Credit Card'];

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  List<Map<String, dynamic>> allAppliedFilters = [];

  void _applyFilters() {
    setState(() {
      Map<String, dynamic> currentFilters = {};

      if (customerNameValue != null && customerNameValue!.isNotEmpty) {
        currentFilters['Customer'] = customerNameValue!;
      }
      if (placeValueChanges != null && placeValueChanges!.isNotEmpty) {
        currentFilters['Place'] = placeValueChanges!;
      }
      if (mobileController.text.isNotEmpty) {
        currentFilters['Mobile'] = mobileController.text;
      }
      if (paymentTypeValue != null && paymentTypeValue!.isNotEmpty) {
        currentFilters['Payment Type'] = paymentTypeValue!;
      }
      if (dateController.text.isNotEmpty) {
        currentFilters['Date'] = dateController.text;
      }

      allAppliedFilters.add(currentFilters);

      customerNameValue = null;
      placeValueChanges = null;
      paymentTypeValue = null;
      selectedCustomerNames.clear();
      placeController.clear();
      paymentController.clear();
      dateController.clear();
      customerNameController.clear();
      mobileController.clear();

      Navigator.pop(context);
    });
  }

  void _showCustomerNameSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Customer Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C2A3A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            customerNameValue = selectedCustomerNames.isEmpty
                                ? null
                                : selectedCustomerNames.join(', ');
                            customerNameController.text =
                                customerNameValue ?? '';
                            selectedCustomerNames.clear();
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1C2A3A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: customerNames.map((name) {
                        final isSelected = selectedCustomerNames.contains(name);
                        return FilterChip(
                          showCheckmark: false,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isSelected)
                                const Icon(Icons.add,
                                    size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                name,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              if (isSelected) const SizedBox(width: 4),
                              if (isSelected)
                                const Icon(Icons.close,
                                    size: 16, color: Colors.white),
                            ],
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF1C2A3A),
                          backgroundColor: Colors.grey.shade300,
                          onSelected: (isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedCustomerNames.add(name);
                              } else {
                                selectedCustomerNames.remove(name);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPlaceSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Select Place',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C2A3A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: place.map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          placeController.text = item;
                          placeValueChanges = item;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Select Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C2A3A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: paymentType.map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          paymentController.text = item;
                          paymentTypeValue = item;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Filter',
          style: TextStyle(
            color: Color(0xFF1C2A3A),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C2A3A),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.grey.shade200,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Filter',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1C2A3A),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1C2A3A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: _showCustomerNameSelection,
                                  child: AbsorbPointer(
                                    child: SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        controller: customerNameController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Customer Name',
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade500,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Place',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1C2A3A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: _showPlaceSelection,
                                  child: AbsorbPointer(
                                    child: SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        controller: placeController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Place',
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade500,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Mobile Number',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1C2A3A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                    controller: mobileController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Mobile Number',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade500),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Payment',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1C2A3A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: _showPaymentSelection,
                                  child: AbsorbPointer(
                                    child: SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        controller: paymentController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Payment',
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade500,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Select Date',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1C2A3A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 17),
                                    hintText: 'Select Date',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade500,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.grey.shade500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF1C2A3A),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF1C2A3A),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date of Birth can not be left empty';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: const Color(0xFF1C2A3A),
                                              onPrimary: Colors.grey.shade200,
                                              surface: Colors.grey.shade200,
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    const Color(0xFF1C2A3A),
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      String formattedDate =
                                          "${picked.day}-${picked.month}-${picked.year}";
                                      dateController.text = formattedDate;
                                    }
                                  },
                                  readOnly: true,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 250,
                                    height: 48,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                                Color(0xFF1C2A3A)),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        _applyFilters();
                                      },
                                      child: const Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allAppliedFilters.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> filterSet = allAppliedFilters[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF1C2A3A)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${filterSet['Customer']}',
                              style: const TextStyle(
                                  color: Color(0xFF1C2A3A), fontSize: 17),
                            ),
                            Text(
                              '${filterSet['Date']}',
                              style: const TextStyle(
                                  color: Color(0xFF1C2A3A), fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Place: ${filterSet['Place']}',
                              style: const TextStyle(
                                  color: Color(0xFF1C2A3A), fontSize: 15),
                            ),
                            Text(
                              filterSet['Payment Type'],
                              style: const TextStyle(
                                  color: Color(0xFF1C2A3A), fontSize: 15),
                            ),
                          ],
                        ),
                        Text(
                          'Mobile No: ${filterSet['Mobile']}',
                          style: const TextStyle(
                              color: Color(0xFF1C2A3A), fontSize: 15),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
