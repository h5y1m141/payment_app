export const fetchResources = async (idToken: string) => {
  const url = `${process.env.REACT_APP_ORIGIN}/admin/api/v2/orders`
  return await fetch(url, {
    headers: {
      Authorization: `Bearer ${idToken}`,
    },
  })
}

export const createCancellationRequestResources = async (
  idToken: string,
  orderId: number
) => {
  const url = `${process.env.REACT_APP_ORIGIN}/admin/api/v2/cancellation_orders`
  const data = {
    order_id: orderId,
  }
  const params = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${idToken}`,
    },
    body: JSON.stringify(data),
  }

  return await fetch(url, params)
}
