enum SortOption { emission, name }
enum OrderOption { desc, asc }


String getSortOptionNameToDisplay(SortOption option) {
  if (option == SortOption.name) {
    return "Name";
  } else if (option == SortOption.emission) {
    return "Carbon Emission";
  } else {
    return "";
  }
}

String getOrderOptionNameToDisplay(OrderOption option) {
  if (option == OrderOption.asc) {
    return "Ascending";
  } else if (option == OrderOption.desc) {
    return "Descending";
  } else {
    return "";
  }
}