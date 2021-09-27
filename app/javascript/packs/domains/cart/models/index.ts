import { Product } from "../../product/models";

export type CartItem = {
  product: Product;
  subTotal: number;
};

const salesTaxRate = 1.08;

export const calcurateCartItem = (
  product: Product,
  quantity: number
): CartItem => {
  const calcuratePrice = product.price * quantity;

  return {
    product: product,
    subTotal: Math.ceil(calcuratePrice * salesTaxRate),
  };
};

export const calcurateTotalPrice = (currentSubTotals) => {
  const totalPrice = currentSubTotals.reduce((previousItem, currentItem) => {
    return previousItem + currentItem;
  }, 0);

  return totalPrice;
};
