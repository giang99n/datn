import React, { useState } from "react";

import { CheckCircleOutlined, CloseCircleOutlined } from "@ant-design/icons";
import { Button, Form, Input, Modal, Select, Tag } from "antd";
import devicesList from "../assets/JsonData/devices-list.json";
import Table from "../components/table/Table";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";

const customerTableHead = [
  "",
  "Tên",
  "Chủ thiết bị",
  "Phòng",
  "Mô tả",
  "Ngày lắp đặt",
  "Ghi chú",
  "Trạng thái",
  "",
  "",
];

const renderHead = (item, index) => <th key={index}>{item}</th>;

const Devices = () => {
  const renderBody = (item, index) => (
    <tr key={index}>
      <td>{item.id}</td>
      <td>{item.name}</td>
      <td>{item.deviceOwner}</td>
      <td>{item.room}</td>
      <td>{item.description}</td>
      <td>{item.installationDate}</td>
      <td>{item.note}</td>
      <td>
        {item.status === "false" ? (
          <Tag icon={<CheckCircleOutlined />} color="success">
            Hoạt động
          </Tag>
        ) : (
          <Tag icon={<CloseCircleOutlined />} color="error">
            Yêu cầu sửa
          </Tag>
        )}
      </td>
      <td>
        <Button type="link" icon={<EditOutlined />} onClick={showModal} />
      </td>
      <td>
        <Button type="link" icon={<DeleteOutlined />} />
      </td>
    </tr>
  );
  const [open, setOpen] = useState(false);
  const [openCreate, setOpenCreate] = useState(false);

  const showModal = () => {
    setOpen(true);
  };

  const hideModal = () => {
    setOpen(false);
  };

  const showModalCreate = () => {
    setOpenCreate(true);
  };

  const hideModalCreate = () => {
    setOpenCreate(false);
  };

  const handleChange = (value) => {
    console.log(`selected ${value}`);
  };
  return (
    <div>
      <div className="row justify-between">
        <div className="col-3">
          <h2 className="page-header">Danh sách thiết bị </h2>
        </div>
        <div className="col-3">
          <div style={{ paddingRight: "55px" }} className="row justify-end">
            <Button type="primary" onClick={showModalCreate}>
              + Thêm mới thiết bị
            </Button>
          </div>
        </div>
      </div>
      <div className="row">
        <div className="col-12">
          <div className="card">
            <div className="card__body">
              <Table
                limit="10"
                headData={customerTableHead}
                renderHead={(item, index) => renderHead(item, index)}
                bodyData={devicesList}
                renderBody={(item, index) => renderBody(item, index)}
              />
            </div>
          </div>
        </div>
      </div>
      <Modal
        title="Cập nhật thiết bị"
        open={open}
        onOk={hideModal}
        onCancel={hideModal}
        okText="OK"
        cancelText="Cancel"
      >
        <Form
          name="basic"
          labelCol={{ span: 8 }}
          wrapperCol={{ span: 16 }}
          style={{ maxWidth: 600 }}
          initialValues={{ remember: true }}
          //   onFinish={onFinish}
          //   onFinishFailed={onFinishFailed}
          autoComplete="off"
        >
          <Form.Item label="Mô tả" name="description">
            <Input />
          </Form.Item>
          <Form.Item label="Ghi chú" name="note">
            <Input />
          </Form.Item>
          <Form.Item label="Trạng thái" name="status">
            <Select
              style={{ width: "100%" }}
              onChange={handleChange}
              options={[
                { value: "succes", label: "Hoạt động" },
                { value: "error", label: "Yêu cầu sửa" },
              ]}
            />
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title="Thêm mới thiết bị"
        open={openCreate}
        onOk={hideModalCreate}
        onCancel={hideModalCreate}
        okText="OK"
        cancelText="Cancel"
      >
        <Form
          name="basic"
          labelCol={{ span: 8 }}
          wrapperCol={{ span: 16 }}
          style={{ maxWidth: 600 }}
          initialValues={{ remember: true }}
          //   onFinish={onFinish}
          //   onFinishFailed={onFinishFailed}
          autoComplete="off"
        >
          <Form.Item label="Tên" name="name">
            <Input />
          </Form.Item>
          <Form.Item label="Chủ thiết bị" name="owner">
            <Select
              style={{ width: "100%" }}
              onChange={handleChange}
              options={[
                { value: "succes", label: "Hoạt động" },
                { value: "error", label: "Yêu cầu sửa" },
              ]}
            />
          </Form.Item>
          <Form.Item label="Phòng" name="room">
            <Input />
          </Form.Item>
          
          <Form.Item label="Mô tả" name="description">
            <Input />
          </Form.Item>
          <Form.Item label="Ngày lắp đặt" name="íntallDate">
            <Input />
          </Form.Item>
          <Form.Item label="Ghi chú" name="note">
            <Input />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default Devices;
