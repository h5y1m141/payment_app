export const fetchResources = async () => {
  return await fetch(`${process.env.REACT_APP_ORIGIN}/customer_api/v1/products`)
}
