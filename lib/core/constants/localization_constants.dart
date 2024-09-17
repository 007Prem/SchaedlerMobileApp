import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/localization_interface.dart';

enum LocalizationConstants {
  firstTimeWelcome(keyword: "Welcome to Optimizely B2B Mobile App"),
  visitWebsite(keyword: "Visit Optimizely.com"),
  signInPrompt(keyword: "Sign in to your B2B Store"),
  existingCustomers(keyword: "Connect Store"),
  enterDomainHint(keyword: "Example: store.optimizely.com"),
  useECommerceWebsite(keyword: "Continue"),
  invalidDomain(keyword: "Invalid Domain"),
  domainWebsiteNotResponding(
      keyword: "The website at the domain you entered is not responding."),
  mobileAppDisabled(keyword: "Mobile App Disabled"),
  mobileAppDisabledDescription(
      keyword: "This website is not enabled for mobile app access."),
  account(keyword: "Account"),
  welcome(keyword: "Welcome"),
  signIn(keyword: "Sign In"),
  signOut(keyword: "Sign Out"),
  termsOfUse(keyword: "Terms of Use"),
  privacyPolicy(keyword: "Privacy Policy"),
  viewAccountOnWebsite(keyword: "View Account on Website"),
  settings(keyword: "Settings"),
  orders(keyword: "Orders"),
  showHidePricing(keyword: "Hide Pricing"),
  showHideInventory(keyword: "Hide Inventory"),
  orderApproval(keyword: "Order Approval"),
  lists(keyword: "Lists"),
  changeCustomer(keyword: "Change Customer"),
  changeCustomerWillCall(keyword: "Change Customer/Delivery Method"),
  version(keyword: "Version"),
  savedOrders(keyword: "Saved Orders"),
  saveOrder(keyword: "Save Order"),
  orderSaved(keyword: "Order Saved"),
  errorLoadingAccount(keyword: "Error Loading Account"),
  mySavedPayments(keyword: "My Saved Payments"),
  edit(keyword: "Edit"),
  selectCard(keyword: "Select Card"),
  selectCountry(keyword: "Select Country"),
  selectState(keyword: "Select State"),
  deleteCard(keyword: "Delete Card"),
  editCreditCard(keyword: "Edit Credit Card"),
  deleteCreditCard(keyword: "Delete Credit Card"),
  month(keyword: "Month"),
  year(keyword: "Year"),
  address(keyword: "Address"),
  cardExpirationDate(keyword: "Card Expiration Date"),
  postalCode(keyword: "Postal Code"),
  username(keyword: "Username"),
  email(keyword: "Email"),
  password(keyword: "Password"),
  submit(keyword: "Submit"),
  enterEmail(keyword: "Enter Email"),
  enterUsername(keyword: "Enter Username"),
  forgotPassword(keyword: "Forgot Password"),
  useBiometricLogin(keyword: "Use {0}"),
  touchID(keyword: "Touch ID"),
  faceID(keyword: "Face ID"),
  fingerprint(keyword: "Fingerprint"),
  dismiss(keyword: "Dismiss"),
  incorrectUsernameOrPassword(keyword: "Incorrect username or password."),
  errorCommunicatingWithTheServer(
      keyword: "There was an error communicating with the server."),
  incorrectLoginOrPassword(keyword: "Incorrect Login or Password."),
  unableToGetCurrentSession(keyword: "Unable to get current session."),
  noLocationFound(keyword: "No location found."),
  authenticationFailed(keyword: "Authentication failed."),
  invalidUsernameAndPasswordCombination(
      keyword: "Invalid Username/Password combination"),
  instructionsEmailStringTemplate(
      keyword:
          "Enter your email and we'll send you an email that will allow you to reset your password."),
  instructionsUsernameStringTemplate(
      keyword:
          "Enter your username and we'll send you an email that will allow you to reset your password."),
  forgotPasswordSuccessfulMessage(
      keyword:
          "If an account matches the username entered, an email will be sent to the associated email address to reset your password. If you do not receive one, please contact customer service."),
  selectBillingAddress(keyword: "Select Billing Address"),
  selectShippingAddress(keyword: "Select Shipping Address"),
  selectPickUpLocation(keyword: "Select Pick Up Location"),
  billingAddress(keyword: "Billing Address"),
  shippingMethod(keyword: "Shipping Method"),
  pickUpLocation(keyword: "Pick Up Location"),
  shippingAddress(keyword: "Shipping Address"),
  recipientAddress(keyword: "Recipient Address"),
  setAsDefault(
      keyword: "Set as default and skip this step next time you log in"),
  cancelSignIn(keyword: "Cancel Sign In"),
  yourChangesWillBeLost(keyword: "Your changes will be lost."),
  ship(keyword: "Ship"),
  pickUp(keyword: "Pick Up"),
  hours(keyword: "Hours"),
  directions(keyword: "Directions"),
  distance(keyword: "Distance"),
  distanceUnit(keyword: "Mi"),
  searchPickUpLocation(keyword: "Search Pick Up Location"),
  oneTimeShippingAddress(keyword: "One-Time Shipping Address"),
  turnOnYourLocationSettingsFor(keyword: "Turn on your location settings for"),
  goToSettings(keyword: "Go to Settings"),
  enableBiometricLogin(keyword: "Enable {0}"),
  clearCache(keyword: "Clear Cache"),
  changeDomain(keyword: "Change Domain"),
  changeEnvironment(keyword: "Change Environment"),
  languages(keyword: "Languages"),
  cacheCleared(keyword: "The cache has been cleared."),
  cacheNotCleared(keyword: "The cache has not been cleared."),
  enterPassword(keyword: "Enter Password"),
  changingDomainInfo(
      keyword:
          "Changing domains will log you out of your current session. Are you sure?"),
  changingEnvironmentInfo(
      keyword:
          "Changing environment will log you out of your current session. Are you sure?"),
  enterPasswordToSetupBiometricLogin(
      keyword: "Enter your password to setup {0}."),
  disableBiometricLoginFailed(keyword: "Disable {0} failed."),
  adminLogout(keyword: "Logout Admin"),
  currentDomain(keyword: "Current Domain"),
  noListsAvailable(keyword: "No Lists Available"),
  listCreated(keyword: "List Created"),
  createNewList(keyword: "Create New List"),
  listDeleted(keyword: "List Deleted"),
  deleteList(keyword: "Delete List"),
  deleteSpecificList(keyword: "Delete %s?"),
  leaveList(keyword: "Leave List"),
  leaveSpecificList(keyword: "Leave %s?"),
  productsOutOfStock(keyword: "Product(s) Out of Stock"),
  productsOutOfStockMessage(
      keyword:
          "There are product(s) out of stock. Add available products to cart?"),
  addListToCart(keyword: "Add List to Cart"),
  listTotal(keyword: "List Total"),
  listTotalProducts(keyword: "List Total (%s products)"),
  productDeleted(keyword: "Product Deleted"),
  errorDeletingProduct(keyword: "Error Deleting Product"),
  listInformation(keyword: "List Information"),
  renameList(keyword: "Rename List"),
  enterListName(keyword: "Enter a name for your list"),
  listSaved(keyword: "List Saved"),
  copyList(keyword: "Copy List"),
  listCopied(keyword: "List Copied"),
  maxCharacters(keyword: "{0} Characters Max"),
  listName(keyword: "List Name"),
  listUpdated(keyword: "List Updated"),
  products(keyword: "Products"),
  private(keyword: "Private"),
  listDetails(keyword: "List Details"),
  usersShared(keyword: "Users Shared"),
  descriptionOptional(keyword: "Description (Optional)"),
  discardChanges(keyword: "Discard changes?"),
  somethingWentWrong(keyword: "Something went wrong."),
  updateFailed(keyword: "Update Failed"),
  copyFailed(keyword: "Copy Failed"),
  renameFailed(keyword: "Rename Failed"),
  sharedWith(keyword: "Shared with %s others"),
  sharedBy(keyword: "Shared by %s"),
  items(keyword: "%s Items"),
  item(keyword: "%s Item"),
  itemNumber(keyword: "Item # %s"),
  removeItem(keyword: "Remove Item"),
  removeItemInfoMessage(
      keyword:
          "Changing quantity to zero will remove this item from your list. Are you sure?"),
  failedToAddToList(keyword: "Failed to add to List"),
  selectList(keyword: "Select List"),
  createNewListInfoMessage(
      keyword: "Creates a new list and adds the product to it."),
  updateOnBy(keyword: "%s by %s"),
  updateBy(keyword: "Updated %s by %s"),
  deleteIsDiscontinued(
      keyword:
          "The product '{0}' have been discontinued. Would you like to remove this item from the list?"),
  deleteItemsIsDiscontinued(
      keyword:
          "There are {0} item(s) on this list have been discontinued. Would you like to remove the items from the list?"),
  totalApprovalOrders(keyword: "{0} Orders"),
  noOrderApprovalsFound(keyword: " No order approvals found."),
  deleteOrder(keyword: "Delete Order"),
  approveOrder(keyword: "Approve Order"),
  orderInformation(keyword: "Order Information"),
  approvingCart(keyword: "Approving Cart"),
  approvingCartInfos(keyword: "Approving %s for %s"),
  noOrdersFound(keyword: "No Orders Found"),
  addOrderContentToCart(keyword: "Add this order's contents to your cart?"),
  filter(keyword: "Filter"),
  status(keyword: "Status"),
  print(keyword: "Print"),
  reorder(keyword: "Reorder"),
  promo(keyword: "Promo {0}"),
  shipments(keyword: "SHIPMENTS"),
  orderSummary(keyword: "Order Summary"),
  productItems(keyword: "PRODUCTS ({0} ITEMS)"),
  trackShipment(keyword: "Track Shipment"),
  requestPickUpDate(keyword: "Requested Pick Up Date"),
  requestDeliveryDate(keyword: "Requested Delivery Date"),
  orderDate(keyword: "Order Date"),
  orderStatus(keyword: "Order Status"),
  terms(keyword: "Terms"),
  orderNumberSign(keyword: "Order #"),
  webOrderNumberSign(keyword: "Web Order #"),
  pONumberSign(keyword: "PO #"),
  subtotal(keyword: "Subtotal"),
  total(keyword: "Total"),
  shipping(keyword: "Shipping"),
  handling(keyword: "Handling"),
  miscCharge(keyword: "Misc. Charge"),
  tax(keyword: "Tax"),
  track(keyword: "Track"),
  orderDetails(keyword: "Order Details"),
  orderNotes(keyword: "Order Notes"),
  shipDate(keyword: "Ship Date"),
  otherCharges(keyword: "Other Charges"),
  orderDeleted(keyword: "Order Deleted"),
  orderApproved(keyword: "Order Approved"),
  orderTotal(keyword: "Order Total"),
  invoiceTotal(keyword: "Invoice Total"),
  selectTotalType(keyword: "Select Total Type"),
  selectType(keyword: "Select Type"),
  enterAmount(keyword: "Enter Amount"),
  greaterThan(keyword: "Greater Than"),
  lessThan(keyword: "Less Than"),
  equalTo(keyword: "Equal To"),
  showMyOrdersOnly(keyword: "Show My Orders Only"),
  addToList(keyword: "Add to List"),
  removeAllProducts(keyword: "Remove All Products"),
  quickOrderBasketEmpty(keyword: "Quick order basket is empty"),
  removeAllQuickOrderProductsQuestion(
      keyword: "Remove all products from your quick order cart?"),
  signInBeforeList(keyword: "Please sign in before proceeding to add to list."),
  signInBeforeSaveOrder(
      keyword: "Please sign in before proceeding to save order."),
  quickOrderContents(keyword: "Quick Order Contents"),
  notFoundForSearch(keyword: "Not found for %s"),
  tooManyResultsForSearch(
      keyword: "There is more than one product that matches %s"),
  addToCartAndCheckout(keyword: "Add to Cart & Checkout"),
  quickOrder(keyword: "Quick Order"),
  addToQuickOrder(keyword: "Add to Quick Order"),
  tapToScan(keyword: "Tap to Scan"),
  takePhoto(keyword: "Take Photo"),
  cancelScan(keyword: "Cancel Scan"),
  multipleBarcodeWarningTitle(keyword: "More than one barcode found"),
  multipleBarcodeWarningMessage(
      keyword: "Please put only one barcode inside the scanning box."),
  updateQuantity(keyword: "Update quantity"),
  unitOfMeasure(keyword: "U/M"),
  partNumberSign(keyword: "Part #"),
  myPartNumberSign(keyword: "My Part #"),
  mFGNumberSign(keyword: "MFG #"),
  packDescription(keyword: "Pack"),
  packSign(keyword: "Pack #"),
  selectSomething(keyword: "Select"),
  documents(keyword: "Documents"),
  recommendedProducts(keyword: "Recommended Products"),
  unableToRetrieveInventory(keyword: "Unable to retrieve inventory"),
  addToCart(keyword: "Add to Cart"),
  pleaseSignInBeforeAddingToList(
      keyword: "Please sign in before adding to list."),
  noFiltersAvailable(keyword: "No Filters Available"),
  brand(keyword: "Brand"),
  productLine(keyword: "Product Line"),
  categories(keyword: "Categories"),
  warehouseInventory(keyword: "Warehouse Inventory"),
  quantityPricing(keyword: "Quantity Pricing"),
  previouslyPurchased(keyword: "Previously Purchased"),
  stockedItems(keyword: "Stocked Items"),
  stockedItemsOnly(keyword: "Stocked Items Only"),
  signInForPricing(keyword: "Sign in for Pricing"),
  signInForAddToCart(keyword: "Sign in for Add To Cart"),
  shopTitle(keyword: "Shop"),
  errorLoadingShop(keyword: "Error Loading Shop"),
  featuredProducts(keyword: "Featured Products"),
  shopBrands(keyword: "Shop Brands"),
  shopCategories(keyword: "Shop Categories"),
  parts(keyword: "Parts"),
  impactDrivers(keyword: "Impact Drivers"),
  liveMode(keyword: "Live Mode"),
  previewMode(keyword: "Preview Mode"),
  switchMode(keyword: "Switch Mode"),
  refresh(keyword: "Refresh"),
  searchLandingTitle(keyword: "Search"),
  errorLoadingSearchLanding(keyword: "Error Loading Search"),
  searchHistory(keyword: "Search History"),
  searchNoHistoryAvailable(keyword: "No Search History Available"),
  clearHistory(keyword: "Clear History"),
  searchNoResults(keyword: "Your search returned no results."),
  searchPrompt(keyword: "Search for products."),
  sort(keyword: "Sort"),
  resultsFor(keyword: "%s result(s) for '%s'"),
  results(keyword: "%s result(s)"),
  searchInsteadFor(keyword: "Search instead for {0}"),
  didYouMean(keyword: "Did you mean {0}"),
  autocompleteCategoryOrBrandCombinedTitle(keyword: "%s in %s"),
  autocompleteSearchCategoryGroupTitle(keyword: "Categories"),
  autocompleteSearchBrandGroupTitle(keyword: "Brands"),
  no(keyword: "No"),
  cart(keyword: "Cart"),
  checkout(keyword: "Checkout"),
  checkoutForApproval(keyword: "Checkout for Approval"),
  errorLoadingCart(keyword: "Error Loading Cart"),
  clearAllItemsInCart(keyword: "Clear all items in cart?"),
  signInBeforeCheckout(
      keyword: "Please sign in before proceeding to checkout."),
  signInBeforeSubmitQuote(
      keyword: "Please sign in before proceeding to submit quote."),
  notSignedIn(keyword: "Not Signed In"),
  clearCart(keyword: "Clear Cart"),
  addDiscount(keyword: "Add Discount"),
  addAllToList(keyword: "Add All to List"),
  cartContents(keyword: "Cart Contents"),
  cartContentsItems(keyword: "Cart Contents (%s Items)"),
  subtotalItems(keyword: "Subtotal (%s Item(s))"),
  continueShopping(keyword: "Continue Shopping"),
  noSavedOrders(keyword: "There are no saved orders."),
  deleteSavedOrder(keyword: "Delete Saved Order"),
  placeSavedOrder(keyword: "Place Saved Order"),
  savedOrdersDetail(keyword: "Saved Orders Detail"),
  orderSavedMessage(keyword: "Order Saved"),
  errorSavingOrder(keyword: "Error Saving Order"),
  qTYTitle(keyword: "QTY"),
  lineNotes(keyword: "Line Notes"),
  inventory(keyword: "Inventory"),
  viewAvailabilityWarehouse(keyword: "View Availability by Warehouse"),
  cartDeleted(keyword: "Cart Deleted"),
  savedOrderDetails(keyword: "Saved Order Details"),
  productsAddToCartSuccess(keyword: "Products added to Cart"),
  cartInvalid(keyword: "Cart is null or invalid"),
  productCanNotBePurchased(keyword: "Product cannot be purchased"),
  productCanNotBeReOrdered(keyword: "Product cannot be re-ordered"),
  shippingHandling(keyword: "Shipping & Handling"),
  youSaved(keyword: "You saved"),
  promotion(keyword: "Promotion"),
  notEnoughInventoryInLocalWarehouse(
      keyword:
          "Quantity of {0} available, the remaining qty will be available in 3-5 days."),
  brands(keyword: "Brands"),
  allBrandCategories(keyword: "All Brand Categories"),
  viewBrandWebsite(keyword: "View Brand Website"),
  shopAllBrandProducts(keyword: "Shop All Brand Products"),
  shopAllBrandCategories(keyword: "Shop All Brand Categories"),
  shopByCategory(keyword: "Shop by Category"),
  shopProductLines(keyword: "Shop Product Lines"),
  shopAllBrandProductLines(keyword: "Shop All Brand Product Lines"),
  topSellers(keyword: "Top Sellers"),
  allBrandProductLines(keyword: "All Brand Product Lines"),
  billingShipping(keyword: "Billing & Shipping"),
  paymentDetails(keyword: "Payment Details"),
  paymentSummary(keyword: "Payment Summary"),
  reviewOrder(keyword: "Review Order"),
  cancelCheckout(keyword: "Cancel Checkout?"),
  orderConfirmation(keyword: "Order Confirmation"),
  orderFailed(keyword: "Order Failed"),
  placeOrder(keyword: "Place Order"),
  promoCodes(keyword: "Promo (%s)"),
  promoCodesMore(keyword: "Promo (%s & %s More)"),
  yourOrderNumber(keyword: "Your Order Number"),
  date(keyword: "Date"),
  selectDate(keyword: "Select Date"),
  carrier(keyword: "Carrier"),
  service(keyword: "Service"),
  requestDeliveryDateOptional(keyword: "Request Delivery Date (optional)"),
  requestPickUpDateOptional(keyword: "Request Pick Up Date (optional)"),
  requestPickUpDateRequired(keyword: "Request Pick Up Date (required)"),
  paymentMethod(keyword: "Payment Method"),
  pONumberOptional(keyword: "PO Number (Optional)"),
  pONumberRequired(keyword: "PO Number (Required)"),
  promotionalCode(keyword: "Promotional Code"),
  jobAccountOptional(keyword: "Job Account(Optional)"),
  shipWhenOrderIsComplete(keyword: "Ship When Order Is Complete"),
  orderNotesOptional(keyword: "Order Notes (Optional)"),
  cardEndingIn(keyword: "Card Ending in {0}"),
  cardExpires(keyword: "Expires {0}"),
  invalidPromotionCode(keyword: "Invalid Promotion Code"),
  promotionApplied(keyword: "Promotion Applied"),
  promotionNotAppliedContinue(
      keyword: "Promotion code not applied. Do you wish to continue?"),
  selectPaymentMethod(keyword: "Select Payment Method"),
  newPaymentMethod(keyword: "+ New Payment Method"),
  newAddress(keyword: "+ New address"),
  backToCountInventory(keyword: "Back to Count Inventory"),
  backToCreateOrder(keyword: "Back to Create Order"),
  backToVmiHome(keyword: "Back to VMI Home"),
  addNonVMIProducts(keyword: "Add Non-VMI Products"),
  submitOrder(keyword: "Submit Order"),
  unableToRetrieveShippingCarriers(
      keyword: "Unable to retrieve shipping carriers."),
  changesWillBeLost(keyword: "Changes will be lost. Are you sure?"),
  name(keyword: "Name"),
  firstName(keyword: "First Name"),
  lastName(keyword: "Last Name"),
  companyName(keyword: "Company Name"),
  expDate(keyword: "Exp. Date"),
  useDifferentBillingAddress(keyword: "Use Different Billing Address"),
  useBillingAddress(keyword: "Use billing address"),
  errorLoadingPage(keyword: "Error Loading Page"),
  errorLoadingProductDetails(keyword: "Error Loading Page"),
  creditCard(keyword: "Credit Card"),
  oneTimeAddress(keyword: "One-Time Address"),
  country(keyword: "Country"),
  zip(keyword: "Zip"),
  state(keyword: "State"),
  addressOne(keyword: "Address One"),
  addressTwo(keyword: "Address Two"),
  addressThree(keyword: "Address Three"),
  addressFour(keyword: "Address Four"),
  addressLine(keyword: "Address line"),
  saveThisAddress(keyword: "Save this address"),
  city(keyword: "City"),
  phoneNumber(keyword: "Phone Number"),
  emailAddress(keyword: "Email Address"),
  promoName(keyword: "Promo {0}"),
  creditCardAddress(keyword: "Credit Card Address"),
  orderSummaryItems(keyword: "Order Summary (%s Items)"),
  cardNumber(keyword: "Card Number"),
  uPS(keyword: "UPS"),
  nextDayAir(keyword: "Next Day Air"),
  mastercard(keyword: "Mastercard"),
  selectCarrier(keyword: "Select Carrier"),
  orderPlacedSuccessfully(keyword: "%s placed successfully"),
  locationFinder(keyword: "Location Finder"),
  searchThisArea(keyword: "Search This Area"),
  resultsUpdated(keyword: "Results Updated"),
  noLocationsFound(keyword: "No Locations Found"),
  noResultFoundMessage(keyword: "No results found, please search again."),
  defaultHintTextOnSearchField(
      keyword: "Zip/Postal Code or City, State/Province or Country:"),
  locationNotFoundMessage(
      keyword:
          "Unable to find location. Check your search location and try again."),
  invoices(keyword: "Invoices"),
  invoice(keyword: "Invoice"),
  invoiceHistory(keyword: "Invoice History"),
  balance(keyword: "Balance"),
  due(keyword: "Due"),
  filterInvoices(keyword: "Filter Invoices"),
  openInvoicesOnly(keyword: "Open Invoices Only"),
  invoiceNumber(keyword: "Invoice Number"),
  invoiceDate(keyword: "Invoice Date"),
  invoiceDueDate(keyword: "Invoice Due Date"),
  pONumber(keyword: "PO Number"),
  orderNumber(keyword: "Order Number"),
  shipToAddress(keyword: "SHIP TO ADDRESS"),
  selectShipToAddress(keyword: "Select Ship To Address"),
  dateRange(keyword: "DATE RANGE"),
  selectFromDate(keyword: "Select From Date"),
  selectToDate(keyword: "Select To Date"),
  fromDateShouldBeLessThanOrEqualToDate(
      keyword: "From Date should be less than or equal To Date"),
  dueDate(keyword: "Due Date"),
  shipToPickUp(keyword: "Ship To / Pick Up"),
  save(keyword: "Save"),
  oK(keyword: "OK"),
  cancel(keyword: "Cancel"),
  error(keyword: "Error"),
  retry(keyword: "Retry"),
  search(keyword: "Search"),
  success(keyword: "Success"),
  failed(keyword: "Failed"),
  failedDueToTimeout(
      keyword:
          "Your request is being processed, but it timed out unexpectedly."),
  failedDueToTimeoutCheckAgain(
      keyword:
          "Your request is being processed, but it timed out unexpectedly. Please check back in a few moments."),
  placeOrderTimeoutCheckAgain(
      keyword:
          "Your order is being processed, but it timed out unexpectedly. Please check back in a few moments."),
  addWishListToCartTimeoutCheckCartAgain(
      keyword:
          "Your request is being processed, but it timed out unexpectedly. Please check your cart in a few moments."),
  enable(keyword: "Enable"),
  sortBy(keyword: "Sort By..."),
  rename(keyword: "Rename"),
  leave(keyword: "Leave"),
  delete(keyword: "Delete"),
  copy(keyword: "Copy"),
  create(keyword: "Create"),
  discard(keyword: "Discard"),
  reset(keyword: "Reset"),
  done(keyword: "Done"),
  remove(keyword: "Remove"),
  continueText(keyword: "Continue"),
  clear(keyword: "Clear"),
  apply(keyword: "Apply"),
  from(keyword: "From"),
  to(keyword: "To"),
  close(keyword: "Close"),
  viewStorefront(keyword: "View Storefront"),
  adminLogin(keyword: "Admin Login"),
  listView(keyword: "List View"),
  gridView(keyword: "Grid View"),
  viewOnWebsite(keyword: "View on Website"),
  discounts(keyword: "Discounts"),
  regularPrice(keyword: "Regular Price"),
  youSave(keyword: "you save"),
  itemNote(keyword: "Item note"),
  emailInvoice(keyword: "Email Invoice"),
  emailTo(keyword: "Email To"),
  subject(keyword: "Subject"),
  message(keyword: "Message"),
  attachment(keyword: "Attachment"),
  typeYourMessageHere(keyword: "Type your message here"),
  emailFrom(keyword: "Email From"),
  send(keyword: "Send"),
  emailSentSuccessfully(keyword: "An email was successfully sent."),
  emailSentFailed(keyword: "Sent email fail"),
  asterisk(keyword: "*"),
  orderSubtotal(keyword: "Order SubTotal"),
  deleteSavedOrderConfirmMessage(keyword: "Delete Saved Order?"),
  expires(keyword: "Expires"),
  endingIn(keyword: "Ending in"),
  defaultCard(keyword: "Default Card"),
  addCreditCard(keyword: "Add a Credit Card"),
  cardType(keyword: "Card Type"),
  selectMonth(keyword: "Select Month"),
  selectYear(keyword: "Select Year"),
  useAsDefaultCard(keyword: "Use as default card"),
  saveCardInformation(keyword: "Save card information"),
  oneTimeCreditCard(keyword: "One time Credit Card"),
  invalidCreditCardNumber(keyword: "Invalid Credit Card Number"),
  invalidCvv(keyword: "Invalid CVV"),
  myQuotes(keyword: "My Quotes"),
  myQuoteDetails(keyword: "MyQuote Details"),
  quote(keyword: "Quote"),
  quotes(keyword: "Quotes"),
  requiresQuote(keyword: "Requires Quote"),
  myJobQuotes(keyword: "My Job Quotes"),
  jobQuote(keyword: "Job Quote"),
  jobQuotes(keyword: "Job Quotes"),
  requested(keyword: "Requested"),
  pending(keyword: "Pending"),
  activeJobs(keyword: "Active Jobs"),
  user(keyword: "User"),
  dateSubmitted(keyword: "Date Submitted"),
  customer(keyword: "Customer"),
  buyer(keyword: "Buyer"),
  quoteInformation(keyword: "Quote Information"),
  submitQuoteType(keyword: "Submit quoteType"),
  deleteQuoteType(keyword: "Delete quoteType"),
  declineQuoteType(keyword: "Decline quoteType"),
  acceptQuoteType(keyword: "Accept quoteType"),
  errorLoadingQuote(keyword: "Error Loading Quote"),
  messages(keyword: "Messages"),
  createAQuote(keyword: "Create a Quote"),
  createQuote(keyword: "Create Quote"),
  submitForQuote(keyword: "Submit for Quote"),
  submitForApproval(keyword: "Submit for Approval"),
  submitQuote(keyword: "Submit Quote"),
  requestQuote(keyword: "Request a Quote"),
  quoteType(keyword: "Quote Type"),
  salesQuote(keyword: "Sales Quote"),
  jobName(keyword: "Job Name"),
  quoteConfirmation(keyword: "Quote Confirmation"),
  viewMyQuotes(keyword: "View My Quotes"),
  jobQuoteRequested(keyword: "Job Quote {0} Requested"),
  salesQuoteRequested(keyword: "Sales Quote {0} Requested"),
  requestedDateRange(keyword: "Requested Date Range"),
  requestedFrom(keyword: "Requested From"),
  requestedTo(keyword: "Requested To"),
  expiresDateRange(keyword: "Expires Date Range"),
  expireFrom(keyword: "Expires From"),
  expireTo(keyword: "Expires To"),
  quoteSign(keyword: "Quote #"),
  salesRep(keyword: "Sales Rep"),
  selectCustomer(keyword: "Select Customer"),
  selectSalesRep(keyword: "Select Sales Rep"),
  selectUser(keyword: "Select User"),
  selectStatus(keyword: "Select Status"),
  selectQuoteType(keyword: "Select Quote Type"),
  proposed(keyword: "Proposed"),
  created(keyword: "Created"),
  rejected(keyword: "Rejected"),
  salesQuotes(keyword: "Sales Quotes"),
  errorLoadingQuoteMessage(keyword: "Error Loading Quote Message"),
  communication(keyword: "Communication"),
  notes(keyword: "Notes"),
  quoteAll(keyword: "Quote All"),
  deleteSalesQuote(keyword: "Delete Sales Quote"),
  deleteJobQuote(keyword: "Delete Job Quote"),
  submitSalesQuote(keyword: "Submit Sales Quote"),
  submitJobQuote(keyword: "Submit Job Quote"),
  quotedPricing(keyword: "Quoted Pricing"),
  deleteQuote(keyword: "Delete Quote"),
  acceptSalesQuote(keyword: "Accept Sales Quote"),
  acceptJobQuote(keyword: "Accept Job Quote"),
  quoteExpiration(keyword: "Quote Expiration"),
  jobExpiration(keyword: "Job Expiration"),
  declineSalesQuote(keyword: "Decline Sales Quote"),
  declineJobQuote(keyword: "Decline Job Quote"),
  viewQuotedPricing(keyword: "View Quoted Pricing"),
  viewQuantityPricing(keyword: "View Quantity Pricing"),
  acceptQuoteMessage(
      keyword:
          "Items in your cart will not be added to your quote order. You will be able to continue shopping and purchase these items after accepting your quote."),
  showLineNotes(keyword: "Show Line Notes"),
  orderQty(keyword: "Order QTY"),
  jobQty(keyword: "Job Qty"),
  purchasedQty(keyword: "Purchased Qty"),
  qtyRemaining(keyword: "Qty Remaining"),
  generateOrder(keyword: "Generate Order"),
  orderQuantityExceed(keyword: "Order quantity exceeds quantity remaining"),
  expirationDate(keyword: "Expiration Date"),
  creatingQuoteFor(keyword: "Creating Quote For"),
  selectAUser(keyword: "Select a User"),
  discountBy(keyword: "Discount By"),
  discountMessage(
      keyword:
          "Price(s) on one or more items do not meet the minimum, please reduce the discount."),
  enterLineNotes(keyword: "Enter Line Notes"),
  lineNotesUpdated(keyword: "Line Notes Updated"),
  submitRequisition(keyword: "Submit Requisition"),
  requisitionConfirmation(keyword: "Requisition Confirmation"),
  addPriceBreak(keyword: "Add Price Break"),
  itemPricing(keyword: "Item Pricing"),
  unitCost(keyword: "Unit Cost"),
  list(keyword: "List"),
  minimum(keyword: "Minimum"),
  quantity(keyword: "Quantity"),
  price(keyword: "Price"),
  max(keyword: "Max"),
  startQtyRequired(keyword: "Start quantity is required"),
  startQtyInvalid(keyword: "Start quantity is not valid"),
  endQtyRequired(keyword: "End quantity is required"),
  endQtyInvalid(keyword: "End quantity is not valid"),
  qtyRangeInvalid(keyword: "Quantity range is not valid"),
  priceRequired(keyword: "Price is required"),
  priceInvalid(keyword: "Price is not valid"),
  noMessageItem(keyword: "There are no message item."),
  removeItemFromTheList(keyword: "Remove item from the list?"),
  quantityIsRequired(keyword: "Quantity is required or greater than 0."),
  notification(keyword: "Notification"),
  vendorManagedInventory(keyword: "Vendor Managed Inventory"),
  location(keyword: "Location"),
  locations(keyword: "Locations"),
  call(keyword: "Call"),
  changeLocation(keyword: "Change Location"),
  currentLocation(keyword: "Current Location"),
  countInventory(keyword: "Count Inventory"),
  createOrder(keyword: "Create Order"),
  enterLocationNote(keyword: "Enter a location note by tapping\n %s below"),
  editLocationNote(keyword: "Edit Location Note"),
  clearOrder(keyword: "Clear Order"),
  orderContents(keyword: "Order Contents"),
  countHistory(keyword: "Count History"),
  selectLocation(keyword: "Select Location"),
  searchLocation(keyword: "Search Location"),
  history(keyword: "History"),
  productInfo(keyword: "Product Info"),
  previousCount(keyword: "Previous Count"),
  previouseOrder(keyword: "Previous Order"),
  countQTY(keyword: "Count QTY"),
  orderQTY(keyword: "Order QTY"),
  orderSign(keyword: "Order #"),
  manufactureSign(keyword: "Manufacture #"),
  binNote(keyword: "Bin Note"),
  binSign(keyword: "Bin #"),
  maxSign(keyword: "Max #"),
  minSign(keyword: "Min #"),
  dateSign(keyword: "Date #"),
  countQTYSign(keyword: "Count QTY:"),
  orderQTYSign(keyword: "Order QTY:"),
  enterBinNote(keyword: "Enter Bin Note"),
  qTY(keyword: "QTY"),
  addToOrder(keyword: "Add To Order"),
  update(keyword: "Update"),
  newCount(keyword: "New Count"),
  updatedBy(keyword: "Updated By"),
  viewAllBinNotes(keyword: "View all Bin Notes"),
  viewNote(keyword: "View note"),
  viewAllOrders(keyword: "View All Orders"),
  count(keyword: "Count"),
  previousOrdersNotFound(
      keyword: "Orders placed at this location will appear here."),
  locationNote(keyword: "Location Note"),
  saveLocationNote(keyword: "Save Location Note"),
  locationNoteUpdated(keyword: "Location Note Updated"),
  noSavedPaymentsFound(keyword: "No saved payments found."),
  invalidUrl(keyword: "Invalid url."),
  failedToLoadUrl(keyword: "Failed to load url."),
  noBrandDetailsFound(keyword: "No details found for this brand"),
  viewMore(keyword: "View More"),
  tryAgain(keyword: "Try Again"),
  errorLoading(keyword: "Error Loading"),
  noInternet(keyword: "No Internet"),
  canNotAddToCart(keyword: "This product cannot be added to the cart."),
  ;

  const LocalizationConstants({
    required this.keyword,
  });

  final String keyword;
}

extension GetLocalized on LocalizationConstants {
  String localized() {
    if (sl<ILocalizationService>()
            .translationDictionary
            ?.containsKey(keyword) ==
        true) {
      return sl<ILocalizationService>().translationDictionary?[keyword] ??
          keyword;
    }
    return keyword;
  }
}
